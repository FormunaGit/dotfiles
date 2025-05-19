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

    stylix.url = "github:danth/stylix/master";
    sops-nix.url = "github:Mic92/sops-nix";

    ignis.url = "github:linkfrg/ignis";
    
    # Hyprland inputs (plugins)
    hyprland.url = "github:hyprwm/Hyprland"; # The Hyprland git repo.
    hyprspace = { # Neat workspace overview plugin.
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows =
        "hyprland"; # Syncs Hyprspace versions with Hyprland
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, sops-nix, astal, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.unimag = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./NewSystem/configuration.nix # The new configuration.nix file
        sops-nix.nixosModules.sops # Sops-nix: Secrets Manager
        inputs.stylix.nixosModules.stylix # Stylix: Theme Manager
        home-manager.nixosModules.home-manager # Home Manager: Home Manager
        {
          nix.settings.trusted-users = [ "formuna" ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.formuna = import ./NewSystem/Home.nix;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.sharedModules = [ sops-nix.homeManagerModules.sops ];
        }
      ];
    };
  };
}
