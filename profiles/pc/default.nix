{ config, pkgs, ... }:
{
  imports = [
    ../common
    ../../services
  ];

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

  virtualisation.waydroid.enable = true;

  # Fonts
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      bqn386  # For BQN
      inconsolata
      nerd-fonts.inconsolata
      noto-fonts
      powerline-fonts
    ];
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # TODO: i3 configuration service module
  #       e.g. https://github.com/BirdeeHub/birdeeSystems/blob/582fe0c1123395c8cc0aa3a1bf6dfa3ce65dcfbb/common/i3/default.nix
  # Desktop, login and window managers
  services.xserver.displayManager.gdm.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  services.xserver.desktopManager.gnome.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";  # chromium/electron wayland support
  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";  # firefox wayland support

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    wlr = {
      enable = true;
      settings.screencast = {
        # NOTE: Must set e.g. output_name = "eDP-2" for host
        max_fps = 30;
        #exec_before = "disable_notifications.sh";
        #exec_after = "enable_notifications.sh";
        chooser_type = "simple";
        chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
      };
    };
    config.common.default = "wlr";
  };
  services.dbus.implementation = "broker";

  programs.nm-applet.enable = true;
  programs.nm-applet.indicator = false;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
}
