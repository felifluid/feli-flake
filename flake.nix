{
  description = "Feli's Flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # Alejandra (Nix Code Formatter)
    alejandra.url = "github:kamadorueda/alejandra/4.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    impermanence,
    alejandra,
    catppuccin,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#lydia'
    nixosConfigurations = {
      lydia = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # impermanence
          impermanence.nixosModules.impermanence

          # main config
          ./hosts/lydia

          # home manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.feli = {
              imports = [
                ./home/home.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };
      willy = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # impermanence
          impermanence.nixosModules.impermanence

          # main config
          ./hosts/willy

          # home manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.feli = {
              imports = [
                ./home/home.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };
    };
  };
}
