{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, ... }: let

    specialArgs = {
      inherit nixos-hardware;
      isDesktop = true;
    };

    system = "x86_64-linux";

    unstable-overlay = final: prev: {
      signal-desktop = nixpkgs-unstable.legacyPackages.${system}.signal-desktop;
      grub2 = nixpkgs-unstable.legacyPackages.${system}.grub2;
    };

  in
  {
    # TODO: Push modules into default.nix for each system
    nixosConfigurations.jamie-fw-nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = specialArgs;
      modules = [
        ({ ... }: { nixpkgs.overlays = [ unstable-overlay ]; })

        nixos-hardware.nixosModules.framework-16-7040-amd
        ./hosts/fw16
        ./profiles/laptop
        ./users/jamie
     ];
    };
    nixosConfigurations.jamie-xps-nixos = nixpkgs.lib.nixosSystem {
      inherit system;
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
