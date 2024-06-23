{ pkgs, config, lib, ... }:
let cfg = config.q.restic;
in
{
  options.q.restic = with lib; {
    enable = mkEnableOption "restic backup configuration";

    backupDate = mkOption {
      type = types.str;
      example = "Sun 02:00";
    };

    repositoryUri = mkOption {
      default = "sftp:backups:jamie";
      type = types.str;
    };

    passwordFile = mkOption {
      default = "%h/.restic-password";
      description = ''
        Path to password file. Format specifiers from systemd
        unit configuration are available'';
    };

    excludeFile = mkOption {
      type = types.str;
      default = "%h/.restic-exclude-file";
      description = ''
        Path to exclude file. Format specifiers from systemd
        unit configuration are available'';
    };
  };

  config = lib.mkIf cfg.enable {
    # TODO: Un-reinvent the wheel
    # (https://search.nixos.org/options?from=0&size=50&sort=relevance&type=packages&query=restic)

    environment.systemPackages = [ pkgs.restic ];

    # Configure restic backups
    systemd.user = {
      services.restic = {
        path = [ pkgs.openssh ];
        environment = {
          RESTIC_REPOSITORY = cfg.repositoryUri;
          RESTIC_PASSWORD_FILE = cfg.passwordFile;
        };
        description = "Restic backup";
        requires = ["default.target"];
        serviceConfig = {
          ExecStart = ''${pkgs.restic}/bin/restic backup %h --exclude-file ${cfg.excludeFile}'';
          RestartSec = "30m";
          Restart = "on-failure";
        };
      };

      timers.restic = {
        description = "Restic backup timer";
        timerConfig = {
          OnCalendar = cfg.backupDate;
          Persistent = true;
        };
        wantedBy = ["timers.target"];
      };
    };
  };
}
