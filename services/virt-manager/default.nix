{ pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  # TODO: Finish this: https://nixos.wiki/wiki/Virt-manager
  #       https://www.reddit.com/r/NixOS/comments/177wcyi/best_way_to_run_a_vm_on_nixos/
}
