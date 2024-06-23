{ pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.redshift.override { withGeolocation = false; })
  ];

  services.redshift = {
    enable = true;
    temperature.day = 6700;
    temperature.night = 3000;
  };
}
