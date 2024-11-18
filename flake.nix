{
  description = "My NixOS configuration";

  inputs = {
    # NOTE: Pinned to unstable revision before amdgpu goes poof
    nixpkgs.url = "github:nixos/nixpkgs/12228ff";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, ... }: let

    specialArgs = {
      inherit nixos-hardware;
      isDesktop = true;
    };

    system = "x86_64-linux";

    signal-overlay = final: prev: {
      signal-desktop = nixpkgs-unstable.legacyPackages.${system}.signal-desktop;
    };

  in
  {
    # TODO: Push modules into default.nix for each system
    nixosConfigurations.jamie-fw-nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = specialArgs;
      modules = [
        ({ ... }: { nixpkgs.overlays = [ signal-overlay ]; })

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
