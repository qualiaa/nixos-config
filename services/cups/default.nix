{ pkgs, ... }:
{
  services.printing.enable = true;
  services.printing.drivers = [pkgs.cups-brother-hll2350dw];
}
