{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./Modules/hardware-configuration.nix # System's preconfigured hardware module.
    (import ./Modules/Packages.nix { inherit pkgs inputs; }) # System Packages.
    (import ./Dots/System) # Custom module for styling and configuring my apps.
    (import ./Dots/Shared/Theme.nix) # Current theme
  ];

  # Polkit.
  security.polkit.enable = true;

  # Weylus for using my phone as a stylus.
  programs.weylus = {
    enable = false; # Currently disabled.
    openFirewall = true; # Needed for accessing the webpage from my phone.
    users = [ "formuna" ]; # Needed for accessing Weylus without root.
  };

  # Flatpak!
  services.flatpak.enable = true;

  # Waydroid
  virtualisation.waydroid.enable = true;

  # Server stuff vvvvv #

  # Nextcloud-related stuff
  ## NGINX Thing ##
  services.nginx.virtualHosts = {
    "cloud.formuna.qzz.io" = {
      forceSSL = true;
      enableACME = true;
    };
    "vault.formuna.qzz.io" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
      };
    };
  };

  ## ACME settings (currently just my email) ## TODO: Use secrets for this
  security.acme = {
    acceptTerms = true;
    defaults.email = (builtins.readFile /etc/my-email);
  };

  ## Nextcloud itself ##
  services.nextcloud = {
    enable = false;
    hostName = "cloud.formuna.qzz.io"; # Got my own domain!

    package = pkgs.nextcloud32; # The newest version nixpkgs has.
    home = "/home/formuna/Data/Nextcloud/Home";

    database.createLocally = true;

    configureRedis = true; # I only let a few people use this server, I'm sure it counts as "small".

    maxUploadSize = "16G"; # Literally what could you need to upload that is greater than 16GB?
    https = true; # Force HTTPS on all links

    autoUpdateApps.enable = true; # Eh why not
    extraAppsEnable = true; # Enable apps on Nextcloud startup
    extraApps = with config.services.nextcloud.package.packages.apps; {
      inherit
        calendar
        contacts
        mail
        notes
        ;
    };

    config = {
      dbtype = "pgsql"; # Use PostgreSQL for the database.
      adminuser = "formuna";
      adminpassFile = "/etc/nextcloud-admin-pass";
    };

    settings = {
      default_phone_region = "CA";
      trusted_domains = [ "localhost" ]; # Local IP for testing
    };
  };

  # Sunshine
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  # Vaultwarden
  services.vaultwarden = {
    enable = true;
    backupDir = "/var/local/vaultwarden/backup";
    # in order to avoid having  ADMIN_TOKEN in the nix store it can be also set with the help of an environment file
    environmentFile = "/var/lib/vaultwarden/vaultwarden.env";
    config = {
      # Refer to https://github.com/dani-garcia/vaultwarden/blob/main/.env.template
      DOMAIN = "https://vault.formuna.qzz.io";
      SIGNUPS_ALLOWED = false;
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      ROCKET_LOG = "critical";
    };
  };

  # Kavita
  services.kavita = {
    enable = true;
    tokenKeyFile = /home/formuna/.config/tokenkeyfile;
  };

  # Cloudflared
  services.cloudflared = {
    enable = false;
    tunnels = {
      "a7988dd9-81db-440a-b223-3b1c737eb020" = {
        credentialsFile = "${config.sops.secrets.cloudflared-creds.path}";
        default = "http_status:404";
      };
    };
  };

  system.stateVersion = "25.05"; # Don't change this value I guess.
}
