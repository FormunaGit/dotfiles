{
  description = "Formuna's desktop NixOS configuration :D";

  nixConfig = {
    substituters = [ 
    	"https://cache.nixos.org" # Official cache server.
	"https://nix-community.cachix.org" # Nix community cache server.
	"https://hyprland.cachix.org" # Hyprland cache server.
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    # NixOS official package source, using the nixos-unstable branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astal = {
      url = "github:Aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix/release-24.11";
    sops-nix.url = "github:Mic92/sops-nix";

    # Hyprland inputs (plugins)
    hyprland.url = "github:hyprwm/Hyprland"; # The Hyprland git repo.
    hyprspace = { # Neat workspace overview plugin.
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland"; # Syncs Hyprspace versions with Hyprland
    };
  };

  outputs =
    { self, nixpkgs, home-manager, chaotic, stylix, sops-nix, ... }@inputs:
    {
      nixosConfigurations.unimag = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./System/configuration.nix # The classic configuration.nix file
          sops-nix.nixosModules.sops
          inputs.stylix.nixosModules.stylix
          chaotic.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            nix.settings.trusted-users = [ "formuna" ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.formuna = import ./System/home.nix;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.sharedModules = [ sops-nix.homeManagerModules.sops ];
          }
        ];
      };
      nixosConfigurations.beaubox = nixpkgs.lib.nixosSystem {
	      system = "aarch64-linux";
	      modules = [
	        ./ExtraHosts/BeauBox/configuration.nix
	        sops-nix.nixosModules.sops
	      ];
      };
    };
}
