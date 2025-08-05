{
  description = "Formuna's desktop NixOS configuration :D";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org" # Official cache server.
      "https://nix-community.cachix.org" # Nix community cache server.
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    # NixOS official package source, using the nixos-unstable branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/master";
    sops-nix.url = "github:Mic92/sops-nix";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim, but Nix.
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Textfox theme for Firefox
    textfox.url = "github:adriankarlen/textfox";

    # Nix-Minecraft
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    # Hydenix
    hydenix.url = "github:richen604/hydenix";

    # Nix-index-database - for comma and command-not-found
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, nix-flatpak, nixvim
    , textfox, ... }@inputs:
    let
      #system = "x86_64-linux";
      #pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.unimag = nixpkgs.lib.nixosSystem {
        inherit (inputs.hydenix.lib) system;
        specialArgs = { inherit inputs; };
        modules = [
          nixvim.nixosModules.nixvim # Nixvim: Neovim Manager
          ./NewSystem/configuration.nix # The new configuration.nix file
          nix-flatpak.nixosModules.nix-flatpak # Declarative Flatpak
          sops-nix.nixosModules.sops # Sops-nix: Secrets Manager
          inputs.stylix.nixosModules.stylix # Stylix: Theme Manager
          #home-manager.nixosModules.home-manager # Home Manager: Home Manager
          inputs.hydenix.inputs.home-manager.nixosModules.home-manager
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
