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
      friend.passwordFile = PasswordDir + "Friend-User-Pass";
    };

    # Groups
    groups = {

      # and people in the trusted group get acces to the Private volume
      trusted = [
        "formuna"
        "friend"
      ];
    };

    # Volumes
    volumes = {
      # Shared volume
      "/" = {
        path = "/home/formuna/Data/Copyparty/Shared";

        access = {
          r = "*"; # All users can read this volume.
          A = [ "formuna" ];
        };

        flags = {
          scan = 60; # Scan every minute.
          rss = true;
        };
      };

      # My private shared files
      "/Private" = {
        path = "/home/formuna/Data/Copyparty/Private";

        access = {
          r = "@trusted";
          A = [ "formuna" ];
        };

        flags = {
          scan = 60;
        };
      };
    };

    settings = {
      i = "0.0.0.0";
      og = true;
      og-ua = "'(Discord|Twitter|Slack)bot'";
    };
  };
}
