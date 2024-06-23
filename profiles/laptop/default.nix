{ pkgs, ... }:
{
  imports = [ ../pc ];

  # TODO: Power management tools

  # Make backlight accessible to video group
  services.udev.extraRules = ''
    SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness", RUN+="${pkgs.coreutils}/bin/chmod 660 /sys/class/backlight/%k/brightness"
  '';

  # Configure touchpad
  services.libinput.enable = true;
  services.libinput.touchpad = {
    naturalScrolling = true;
    disableWhileTyping = true;
  };
}
