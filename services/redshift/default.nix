{ pkgs, ... }:
{
  services.redshift = {
    enable = true;
    package = pkgs.gammastep;
    executable = "/bin/gammastep";
    temperature.day = 6700;
    temperature.night = 3000;
  };
}
