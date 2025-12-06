{ pkgs, inputs, ... }: {
  # The overlay
  nixpkgs.overlays = [ inputs.copyparty.overlays.default ];

  # The package
  environment.systemPackages = [ pkgs.copyparty ];

  # The settings
  services.copyparty = {
    enable = true;

    # Accounts
    accounts = {
      formuna.passwordFile =
        "/home/formuna/Data/ServerSettings/Copyparty/Formuna-User-Pass"; # My account
      kat.passwordFile =
        "/home/formuna/Data/ServerSettings/Copyparty/Kat-User-Pass"; # A friend
    };

    # Groups
    groups = {
      # People in the Bookworms group get to access the Books volume
      bookworms = [ "formuna" "kat" ];
    };

    # Volumes
    volumes = {
      # Shared volume
      "/" = {
        path = "/home/formuna/Data/Copyparty/Shared";

        access = {
          r = "*"; # All users can read this volume,
          rw = [ "formuna" ]; # but only I can write.
        };

        flags = { scan = 60; };
      };

      # My book collection.
      "/books" = {
        path = "/home/formuna/Data/Copyparty/Books";

        access = {
          r = "@bookworms";
          rw = [ "formuna" ];
        };

        flags = { scan = 60; };
      };
    };

    settings = { 
      i = "0.0.0.0"; 
    };
  };
}
