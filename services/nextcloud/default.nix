{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.nextcloud-client ];

  systemd.user.services.nextcloud = {
    description = "Nextcloud Client user-service";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.nextcloud-client}/bin/nextcloud";
      RestartSec = 5;
      Restart = "on-failure";
    };
    wantedBy = [ "default.target" ];
  };
}
