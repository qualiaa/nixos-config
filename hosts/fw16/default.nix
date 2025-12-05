{ lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "jamie-fw-nixos";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/c270fc7e-ae4b-433e-a4ac-3aced442107d";
      preLVM = true;
    };
  };

  fileSystems."/".options = [ "compress=lzo" "noatime" ];

  virtualisation.docker.storageDriver = "btrfs";


  services.restic.backups.fw16.user = "jamie";
  services.restic.backups.fw16.repositoryFile = "/home/jamie/.restic-repository";
  services.restic.backups.fw16.passwordFile = "/home/jamie/.restic-password";
  services.restic.backups.fw16.environmentFile = "/home/jamie/.restic-env";
  services.restic.backups.fw16.extraBackupArgs = [
    "--exclude-file=/home/jamie/.restic-exclude-file"
  ];
  services.restic.backups.fw16.paths = [ "/home/jamie" ];
  services.restic.backups.fw16.pruneOpts = [
    "--keep-daily 7"
    "--keep-weekly 5"
    "--keep-monthly 12"
    "--keep-yearly 75"
  ];

  services.restic.backups.fw16.timerConfig = {
    OnCalendar = "12:00";
    Persistent = true;
    RandomizedDelaySec = "5h";
  };

  services.blueman.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  #networking.firewall.allowedTCPPortRanges = [
  #  { from = 5757; to = 5768; }
  #];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Do NOT change this value unless you have manually inspected all the changes
  # it would make to your configuration, and migrated your data accordingly.
  system.stateVersion = "24.11"; # Did you read the comment?
}
