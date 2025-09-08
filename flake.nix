{
  description = "Formuna's desktop NixOS configuration :D";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org" # Official cache server.
      "https://nix-community.cachix.org" # Nix community cache server.
      "https://hyprland.cachix.org" # Hyprland cache server.
    ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
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

    # Ignis
    ignis = {
      url = "github:ignis-sh/ignis";
      # ! Important to override
      # Nix will not allow overriding dependencies if the input
      # doesn't follow your system pkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    { nixpkgs, home-manager, sops-nix, nix-flatpak, nixvim, ... }@inputs: {
      nixosConfigurations.unimag = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          nixvim.nixosModules.nixvim # Nixvim: Neovim Manager
          ./NewSystem/configuration.nix # The new configuration.nix file
          nix-flatpak.nixosModules.nix-flatpak # Declarative Flatpak
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
      nixosConfigurations.windel = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./Windel/configuration.nix
        ];
      };
    };
}
