{ lib, pkgs, ... }:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      trusted-users = [ "@wheel" ];
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };


  # UK Locale
  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = "Europe/London";
  location.latitude = 51.;
  location.longitude = -1.;
  console.keyMap = "uk";

  # Networking services
  networking.networkmanager.enable = true;
  services.avahi = {
    enable = true;
    ipv4 =  true;
    ipv6 = true;
    nssmdns4 = true;
  };

  # Shell config
  # TODO: reproduce zshrc here
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  # TODO: There may be a more sensible permanent home for this
  programs.ssh.extraConfig = ''
    Host gh
      Hostname github.com
      User git

    Host crucible
      Hostname crucible.luffy.ai
      User git

    Host piserve
      Hostname piserve
      User jamie

    Host backups
      Hostname piserve
      User backups
  '';

  # Basic packages
  environment.systemPackages = with pkgs; [
    curl
    dnsutils
    fzf
    git
    jq
    lsof
    nmap
    inetutils
    iotop
    lm_sensors
    p7zip
    pciutils
    ripgrep
    rsync
    screen
    usbutils
    vim
    wget
  ];
}
