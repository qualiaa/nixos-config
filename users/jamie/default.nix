{ lib, config, pkgs, isDesktop, ... }:
{
  users.users.jamie = {
    isNormalUser = true;
    description = "Jamie";
    extraGroups = [ "docker" "networkmanager" "wheel" "video" "libvirtd" ];
    shell = pkgs.zsh;

    packages = with pkgs; [] ++ (lib.optionals isDesktop [
      # Networking
      bluez

      # Fundamental tools
      kitty
      emacs
      vim-full

      # Languages
      cbqn
      python3  # NB: pythonFull includes tcl etc, but this is just for basic support

      # Applications
      audacity
      firefox
      gimp
      inkscape
      krita
      libreoffice
      meld
      musescore
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
      python312Packages.pygments

      # Desktop utilities
      i3status
      grim  # screenshot regions
      mako  # notifications
      pavucontrol
      pulseaudio-ctl
      rofi
      slurp  # screenshot capture
      swaybg  # set wallpapers
      wl-clipboard  # clipboard
      wev
      xfce.thunar
      xfce.tumbler
      zenith

      # Nix tools
      binutils
      nix-prefetch-scripts
      patchelf
      pkg-config

      # CLI tools
      bat
      comma
      perf
      difftastic
      eza
      fd
      screenfetch
      tree
    ]);
  };
}
