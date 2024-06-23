{ lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "jamie-fw-nixos";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/eb3ca2b8-f17b-4468-ae9c-33bd4114572c";
      preLVM = true;
    };
  };

  fileSystems."/".options = [ "compress=lzo" "noatime" ];
  fileSystems."/home".options = [ "compress=lzo" "noatime" ];

  q.restic.backupDate = "Sat 02:00";

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
  system.stateVersion = "23.11"; # Did you read the comment?
}
