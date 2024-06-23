{ lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "jamie-xps-nixos";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-24dc2aad-a0de-4412-bd1e-3ccf96550e8b".device = "/dev/disk/by-uuid/24dc2aad-a0de-4412-bd1e-3ccf96550e8b";

  # TODO: Copy required configuration files
  q.restic.enable = lib.mkForce false;
  q.restic.backupDate = "Sun 02:00";

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
