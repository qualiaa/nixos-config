{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }: let
    specialArgs = {
      inherit nixos-hardware;
      isDesktop = true;
    };
  in
  {
    # TODO: Push modules into default.nix for each system
    nixosConfigurations.fw16 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = specialArgs;
      modules = [
        nixos-hardware.nixosModules.framework-16-7040-amd
        ./hosts/fw16
        ./profiles/laptop
        ./users/jamie
     ];
    };
    nixosConfigurations.jamie-xps-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = specialArgs;
      modules = [
        nixos-hardware.nixosModules.dell-xps-13-9370
        ./hosts/jamie-xps-nixos
        ./profiles/laptop
        ./users/jamie
      ];
    };
  };
}

