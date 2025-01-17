{ lib, config, pkgs, isDesktop, ... }:
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
      emacs
      vim-full

      # Languages
      cbqn
      python3  # NB: pythonFull includes tcl etc, but this is just for basic support

      # Applications
      firefox
      gimp
      inkscape
      krita
      libreoffice
      meld
      strawberry
      zotero

      # Messengers
      discord
      element-desktop
      signal-desktop

      # Viewers
      feh
      vlc
      zathura
      rmview

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
      xfce.thunar
      xfce.tumbler
      xorg.xev
      xorg.xprop
      xsel
      zenith

      # Nix tools
      binutils
      nix-prefetch-scripts
      patchelf
      pkg-config

      # CLI tools
      bat
      comma
      config.boot.kernelPackages.perf
      difftastic
      eza
      fd
      screenfetch
    ]);
  };
}
