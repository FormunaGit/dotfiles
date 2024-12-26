{
  description = "A simple NixOS flake with home-manager and ags";

  inputs = {
    # NixOS official package source, using the nixos-unstable branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager input (is the master branch equivalent to nixos-unstable?)
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # AGS input
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ags, ... }: {
    # NixOS System Configuration
    nixosConfigurations.unimag = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix # The classic configuration.nix file
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.formuna = import ../../home.nix;
        }
      ];
    };

    # Home Manager Standalone Configuration
    homeConfigurations."formuna" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { system = "x86_64-linux"; };

      # Pass inputs as specialArgs
      extraSpecialArgs = { inherit inputs; };

      # Import home.nix
      modules = [ ../../home.nix ];
    };
  };
}
