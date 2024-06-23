{ config, pkgs, ... }:
{
  imports = [
    ../common
    ../../services
  ];

  q.restic.enable = true;

  # X11 config
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "gb";
      variant = "";
      options = "caps:escape";
    };
  };

  # TODO: i3 configuration service module
  #       e.g. https://github.com/BirdeeHub/birdeeSystems/blob/582fe0c1123395c8cc0aa3a1bf6dfa3ce65dcfbb/common/i3/default.nix
  # Desktop, login and window managers
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  programs.nm-applet.enable = true;
  programs.nm-applet.indicator = false;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
}
