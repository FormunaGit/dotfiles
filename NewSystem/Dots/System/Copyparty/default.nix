{ pkgs, inputs, ... }: {
  # The overlay
  nixpkgs.overlays = [ inputs.copyparty.overlays.default ];
  
  # The package
  environment.systemPackages = [ pkgs.copyparty ];

  # The settings
  services.copyparty = {
    enable = true;

    # Maybe I'll add more people someday...
    accounts.formuna = {
      passwordFile = "/home/formuna/Data/ServerSettings/Copyparty/Formuna-User-Pass";
    };

    volumes = {
      "/" = { # Shared volume
        path = "/home/formuna/Data/Copyparty/Shared";

	access = {
	  r = "*"; # All users can read this volume,
	  rw = [ "formuna" ]; # but only I can write.
	};

	flags = {
	  scan = 60;
	};
      };
    };
  };
}
