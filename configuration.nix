{
  config,
  pkgs,
  inputs,
  ...
}:
let
  hyprpkgs = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  hypr = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ./Modules/hardware-configuration.nix # System's preconfigured hardware module.
    (import ./Modules/Packages.nix { inherit pkgs inputs; }) # System Packages.
    (import ./Dots/System) # Custom module for styling and configuring my apps.
  ];

  # Allow non-FOSS packages.
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes and the unified Nix command.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader and OBS VCam settings
  boot = {
    loader = {
      systemd-boot.enable = true; # Systemd-boot. Simple.
      efi.canTouchEfiVariables = true;
    };
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ]; # Kernel modules
    kernelModules = [ "v4l2loopback" ]; # Activate(?) kernel modules
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    ''; # OBS Virtual Camera settings

    #kernelPackages = pkgs.linuxKernel.packages.linux_zen; # Zen kernel
    blacklistedKernelModules = [ "rtw88_8821cu" ]; # Disable this Wifi driver
    kernelParams = [ "video=DP-1:1920x1080@60" ];
  };

  # Allow all firmware regardless of license.
  hardware.enableAllFirmware = true;

  # Nix-LD for binaries.
  programs.nix-ld.enable = true;

  # Add Swapfile
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024;
    }
  ];

  # Mount my data drive
  fileSystems."/run/media/formuna/Data" = {
    enable = false;
    fsType = "btrfs";
    device = "/dev/sda1";
    options = [
      "users"
      "rw"
      "exec"
      "user"
      "umask=000"
    ];
  };

  # Graphics drivers
  hardware.graphics = {
    package = hyprpkgs.mesa; # Use Hyprland's Mesa package
    package32 = hyprpkgs.pkgsi686Linux.mesa; # Don't forget 32-bit!
    enable32Bit = true; # Enable 32-bit support
  };

  # Networking stuff + set the system hostname.
  networking = {
    hostName = "unimag"; # System Hostname
    networkmanager.enable = true; # Enable NetworkManager since I need Wi-Fi.
    firewall.allowedUDPPorts = [
      51820 # Wireguard
      443 # HTTPS
      3478 # Who knows.
      25565 # MC Java
      19132 # MC Bedrock
    ];
    firewall.allowedTCPPorts = [
      2234 # Soulseek
      80 # HTTP
      443 # HTTPS
      8443 # Crafty
      3478 # Something that's for sure.
      25565 # MC Java
      19132 # MC Bedrock
    ];
  };
  services.resolved.enable = true; # The systemd DNS resolver daemon.

  # Speaking of which, WireGuard!
  networking.wireguard.enable = true;

  # Bluetooth stuff
  hardware.bluetooth.enable = true;

  # My timezone.
  time.timeZone = "America/Moncton";

  # Set "internationalisation properties"
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable sound with Pipewire (plus some backwards compatibility)
  security.rtkit.enable = true; # This is related to Pipewire so...
  services.pipewire = {
    enable = true; # Enable Pipewire
    alsa.enable = true; # Enable ALSA support
    alsa.support32Bit = true; # Enable 32-bit ALSA support
    pulse.enable = true; # Enable PulseAudio support
    jack.enable = true; # Enable JACK support
  };

  # Define the "formuna" user account. (that's me!)
  users = {
    defaultUserShell = pkgs.fish; # Sets Fish as the default shell.
    users.formuna = {
      isNormalUser = true; # This account is for a human.
      description = "Formuna"; # The human readable name of the user.
      extraGroups = [
        "networkmanager" # Control over NetworkManager
        "wheel" # Sudo privileges
        "adbusers" # Access to sudo-less ADB
        "uinput" # Not sure what this is for, but if it ain't broke...
        "kvm" # Control over KVM-powered VMs
        "video" # For display/graphics access
        "xorg" # For X11 access
        "docker" # For Docker
      ];
    };
  };

  # ADB for controlling my phone via WIFI or USB
  programs.adb.enable = true;

  # Polkit.
  security.polkit.enable = true;

  # Weylus for using my phone as a stylus.
  programs.weylus = {
    enable = false; # Currently disabled.
    openFirewall = true; # Needed for accessing the webpage from my phone.
    users = [ "formuna" ]; # Needed for accessing Weylus without root.
  };

  # LightDM.
  # Disabled cuz it's causing me issues.
  services.xserver.enable = false;
  services.xserver.displayManager.lightdm.enable = false;

  # Enable fish
  programs.fish.enable = true;

  # And enable Starship
  programs.starship.enable = true;

  # NUR!!
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") {
      inherit pkgs;
    };
  };

  # Steam
  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true; # Open firewall for servers.
    protontricks.enable = true; # Valve-flavored Winetricks.
    extraCompatPackages = [ pkgs.proton-ge-bin ]; # ProtonGE.
  };

  # Flatpak!
  services.flatpak = {
    enable = true;
    packages = [
      "com.github.tchx84.Flatseal" # GUI for Flatpak permissions
      "org.vinegarhq.Sober" # Roblox
      "org.vinegarhq.Vinegar" # Roblox Studio
      "com.rafaelmardojai.Blanket" # Noises
      "com.github.wwmm.easyeffects" # Audio effects
      "org.godotengine.Godot" # Godot game engine
    ];
  };

  # Waydroid
  virtualisation.waydroid.enable = true;

  # Hyprland!
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    # set the flake package
    package = hypr.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = hypr.xdg-desktop-portal-hyprland;
  };

  # Server stuff vvvvv #

  # SSH
  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    openFirewall = true;
    settings = {
      PasswordAuthentication = false; # Disable password auth and prefer keys
      KbdInteractiveAuthentication = false; # ^^^^^^^^^^
      PermitRootLogin = "no"; # Do not allow access to root user.
      AllowUsers = [ "formuna" ]; # Only allow access to my own account.
    };
  };
  services.fail2ban.enable = true; # Temp-ban anyone who tries guessing my password too much.
  services.endlessh = {
    # Neat SSH tarpit for scrapers out there. Why not?
    enable = true;
    port = 22; # Real SSH uses port 2222
    openFirewall = true;
  };

  # Docker
  virtualisation.docker.enable = true;

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
    enable = true;
    hostName = "cloud.formuna.qzz.io"; # Got my own domain!

    package = pkgs.nextcloud32; # The newest version nixpkgs has.

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

  # Code server
  services.code-server = {
    enable = false; # DISABLED
    disableTelemetry = true;
    auth = "none";
    host = "100.79.29.23";
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
