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

    sops-nix.url = "github:Mic92/sops-nix";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-ified kickstart.nvim
    kickstart-nixvim.url = "github:JMartJonesy/kickstart.nixvim";

    # Textfox theme for Firefox
    textfox.url = "github:adriankarlen/textfox";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # AWWW
    awww.url = "git+https://codeberg.org/LGFae/awww";

    # Copyparty
    copyparty.url = "github:9001/copyparty";

    # MCP server config
    mcp-servers-nix.url = "github:natsukium/mcp-servers-nix";

    # NixOS FHS Compat
    nixos-fhs-compat = "github:balsoft/nixos-fhs-compat";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      sops-nix,
      nix-flatpak,
      copyparty,
      ...
    }@inputs:
    {
      nixosConfigurations.unimag = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix # The configuration.nix file
          nix-flatpak.nixosModules.nix-flatpak # Declarative Flatpak
          sops-nix.nixosModules.sops # Sops-nix: Secrets Manager
          home-manager.nixosModules.home-manager # Home Manager: Home Manager
          copyparty.nixosModules.default # Copyparty: Portable file server
          {
            nix.settings.trusted-users = [ "formuna" ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.formuna = import ./Modules/Home.nix;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.sharedModules = [ sops-nix.homeManagerModules.sops ];
          }
        ];
      };
    };
}
