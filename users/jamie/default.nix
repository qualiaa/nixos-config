{ lib, pkgs, isDesktop, ... }:
{
  users.users.jamie = {
    isNormalUser = true;
    description = "Jamie";
    extraGroups = [ "docker" "networkmanager" "wheel" "video" ];
    shell = pkgs.zsh;

    packages = with pkgs; [] ++ (lib.optionals isDesktop [
      # Networking
      bluez
      networkmanager-openvpn
      networkmanagerapplet
      openvpn

      # Fundamental tools
      (rxvt-unicode.override { configure = _: { perlDeps = with perl538Packages; [ commonsense LinuxFD SubExporter SubInstall DataOptList ParamsUtil ]; };})
      rxvt-unicode
      emacs
      vim-full

      # Languages
      cbqn
      python3  # NB: pythonFull includes tcl etc, but this is just for basic support

      # Applications
      discord
      element-desktop
      firefox
      gimp
      inkscape
      libreoffice
      strawberry
      zotero

      # Viewers
      feh
      vlc
      zathura

      # Fonts
      bqn386  # For BQN
      inconsolata  # FIXME: this package doesn't add inconsolata to fc-cache
      noto-fonts  # For other scripts
      powerline-fonts

      # Documentation
      pandoc
      texliveFull

      # Desktop utilities
      dunst
      libnotify
      numlockx
      pavucontrol
      pulseaudio-ctl
      rofi
      scrot
      xsel
      xorg.xev
      xorg.xprop
      zenith

      # Nix tools
      nix-prefetch-scripts

      # CLI tools
      comma
      screenfetch
    ]);
  };
}
