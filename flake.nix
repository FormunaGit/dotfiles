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

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # Textfox theme for Firefox
    textfox.url = "github:adriankarlen/textfox";

    # Copyparty
    copyparty.url = "github:9001/copyparty";

    # Sops-Nix for secrets
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hermes Agent
    hermes-agent.url = "github:NousResearch/hermes-agent";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-flatpak,
      copyparty,
      sops-nix,
      hermes-agent,
      ...
    }@inputs:
    {
      nixosConfigurations.unimag = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        system = "x86_64-linux";
        modules = [
          ./configuration.nix # The configuration.nix file
          nix-flatpak.nixosModules.nix-flatpak # Declarative Flatpak
          home-manager.nixosModules.home-manager # Home Manager: Home Manager
          copyparty.nixosModules.default # Copyparty: Portable file server
          sops-nix.nixosModules.sops # Sops-Nix: Atomic secret provisioning
          hermes-agent.nixosModules.default # Hermes Agent:
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
