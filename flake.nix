{
  description = "Formuna's desktop NixOS configuration :D";

  #nixConfig = {
  #  substituters =
  #    [ "https://cache.nixos.org" "https://nix-community.cachix.org" ];
  #  trusted-public-keys = [
  #    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  #  ];
  #};

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
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs =
    { self, nixpkgs, stylix, home-manager, chaotic, agenix, ... }@inputs:
    let system = "x86_64-linux";
    in {
      # Please replace unimag with your hostname
      nixosConfigurations.unimag = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./System/configuration.nix # The classic configuration.nix file
          chaotic.nixosModules.default
          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
          {
            nix.settings.trusted-users = [ "formuna" ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.formuna = import ./System/home.nix;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
          stylix.nixosModules.stylix
          ./System/configuration.nix
        ];
      };
    };
}
