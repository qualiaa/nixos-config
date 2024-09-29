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

  # Fonts
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      bqn386  # For BQN
      inconsolata
      inconsolata-nerdfont
      noto-fonts
      powerline-fonts
    ];
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
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
