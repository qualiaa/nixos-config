{ pkgs, ... }:
{
  services.redshift = {
    enable = true;
    package = pkgs.gammastep;
    executable = "/bin/gammastep";
    temperature.day = 6700;
    temperature.night = 3000;
  };

  # Needed by hooks
  systemd.user.services.redshift.path = with pkgs; [
    bash
    gawk
    glib
    jq
    kitty
    procps
    sway
  ];
}
