{
  pkgs,
  inputs,
  ...
}:
let
  PasswordDir = "/home/formuna/Data/ServerSettings/Copyparty/";
in
{
  # The overlay
  nixpkgs.overlays = [ inputs.copyparty.overlays.default ];

  # The package
  environment.systemPackages = [ pkgs.copyparty ];

  # The settings
  services.copyparty = {
    enable = true;

    # Accounts
    accounts = {
      formuna.passwordFile = PasswordDir + "Formuna-User-Pass"; # My account
      kat.passwordFile = PasswordDir + "Kat-User-Pass";
      starry.passwordFile = PasswordDir + "Starry-User-Pass";
      nico.passwordFile = PasswordDir + "Nico-User-Pass";
    };

    # Groups
    groups = {
      # People in the Bookworms group get to access the Books volume
      bookworms = [ "kat" ];

      # and people in the trusted group get acces to the Private volume
      trusted = [
        "formuna"
        "starry"
        "nico"
      ];
    };

    # Volumes
    volumes = {
      # Shared volume
      "/" = {
        path = "/home/formuna/Data/Copyparty/Shared";

        access = {
          r = "*"; # All users can read this volume,
          A = [ "formuna" ]; # but only I can write.
        };

        flags = {
          scan = 60;
        };
      };

      # My book collection.
      "/books" = {
        path = "/home/formuna/Data/Copyparty/Books";

        access = {
          r = "@bookworms";
          A = [ "formuna" ];
        };

        flags = {
          scan = 60;
        };
      };

      # My private shared files
      "/private" = {
        path = "/home/formuna/Data/Copyparty/Private";

        access = {
          r = "@trusted";
          A = [ "@trusted" ];
        };

        flags = {
          scan = 60;
        };
      };
    };

    settings = {
      i = "0.0.0.0";
      og-ua = "(Discord|Twitter|Slack)bot";
    };
  };
}
