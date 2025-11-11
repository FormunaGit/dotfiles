{ config, pkgs, inputs, ... }:
let
  hyprpkgs =
    inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  hypr = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
  obs_vcam_name = "OBS Virtual Camera";
in {
  imports = [
    ./Modules/hardware-configuration.nix # System's preconfigured hardware module.
    (import ./Modules/Packages.nix { inherit pkgs inputs; }) # System Packages.
    (import ./Dots/System) # Custom module for styling and configuring my apps.
  ];

  # Virtual desktop service using Xvfb and LXDE
  #systemd.services.virtual-desktop = {
  #  description = "Virtual Desktop Environment";
  #  wantedBy = [ "multi-user.target" ];
  #  after = [ "network.target" ];
  #  
  #  serviceConfig = {
  #    Type = "simple";
  #    User = "formuna";
  #    ExecStart = "${pkgs.bash}/bin/bash -c 'exec ${pkgs.xorg.xvfb}/bin/Xvfb :99 -screen 0 1920x1080x24 -ac +extension RANDR +render -noreset & export DISPLAY=:99; exec ${pkgs.lxsession}/bin/lxsession'";
  #    Restart = "always";
  #    RestartSec = 5;
  #    Environment = [
  #      "DISPLAY=:99"
  #    ];
  #  };
  #};

  # Sway for headless displays
  programs.sway.enable = true;

  # WayVNC
  programs.wayvnc.enable = true;

  # Also add an environment variable to make sure applications know about the virtual display
  environment.variables = {
    DISPLAY = ":99";
  };

  # Allow non-FOSS packages.
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes and the unified Nix command.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader and OBS VCam settings
  boot = {
    loader = {
      systemd-boot.enable = true; # Systemd-boot. Simple.
      efi.canTouchEfiVariables = true;
    };
    extraModulePackages =
      [ config.boot.kernelPackages.v4l2loopback ]; # Kernel modules
    kernelModules = [ "v4l2loopback" ]; # Activate(?) kernel modules
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="${obs_vcam_name}" exclusive_caps=1
    ''; # OBS Virtual Camera settings

    #kernelPackages = pkgs.linuxKernel.packages.linux_zen; # Zen kernel
    blacklistedKernelModules = [ "rtw88_8821cu" ]; # Disable this Wifi drivers
    kernelParams = [ "video=DP-1:1920x1080R@60D" ];
  };

  # Allow all firmware regardless of license.
  hardware.enableAllFirmware = true;

  # Nix-LD for binaries.
  programs.nix-ld.enable = true;

  # Add Swapfile
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 4 * 1024;
  }];

  # Mount my data drive
  #fileSystems.datadrive = {
  #  enable = true;
  #  fsType = "xfs";
  #  device = "/dev/sda1";
  #  mountPoint = "/media/formuna/Data";
  #};

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
    firewall.allowedUDPPorts = [ 51820 # wireguard
      443 3478 25565 19132 25575 # Server ports. In order, HTTPS, idk, MC Java, MC Bedrock, RCON.
    ]; 
    firewall.allowedTCPPorts = [ 2234 # Soulseek
      80 8443 443 3478 25565 19132 # Srv ports 1/2 in order, HTTP, Crafty, HTTPS, idk, MCJava, MCBedrock.
      25575 # And RCON.
    ];
  };
  services.resolved.enable = true; # The systemd DNS resolver daemon.

  # Speaking of which, WireGuard!
  networking.wireguard.enable = true;

  # And then Tailscale!
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client"; # My PC isn't a server.
    openFirewall = true; # Opens port in firewall.
  };

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
      ];
    };
  };

  # ADB for controlling my phone via WIFI or USB
  programs.adb.enable = true;

  # Polkit.
  security.polkit.enable = true;

  # Weylus for using my phone as a stylus.
  programs.weylus = {
    enable = false;
    openFirewall = true; # Needed for accessing the webpage from my phone.
    users = [ "formuna" ]; # Needed for accessing Weylus without root.
  };

  # Input remapper for remapping inputs.
  services.input-remapper = {
    enable = true;
    enableUdevRules = true;
  };

  # Forgot to leave GDM installed... Oh well, I always wanted to try a new DM.
  services.displayManager.ly.enable = true;

  # Enable fish
  programs.fish.enable = true;

  # And enable Starship
  programs.starship = {
    enable = true;
    # Additional configuration options can be added here.
  };

  # NUR!!
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball
      "https://github.com/nix-community/NUR/archive/main.tar.gz") {
        inherit pkgs;
      };
  };

  # Steam
  programs.steam = {
    # The best game launcher.
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

  # OpenRazer
  hardware.openrazer = {
    enable = false;
    keyStatistics = true;
    users = [ "formuna" ];
  };

  # Ungoogled Chromium
  programs.chromium = {
    enable = true;
    defaultSearchProviderSearchURL = "https://search.im-in.space/search?q={searchTerms}";
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
      AllowUsers = ["formuna"]; # Only allow access to my own account.
    };
  };
  services.fail2ban.enable = true; # Temp-ban anyone who tries guessing my password too much.
  services.endlessh = { # Neat SSH tarpit for scrapers out there. Why not?
    enable = true;
    port = 22; # Real SSH uses port 2222
    openFirewall = true;
  };

  # Docker
  virtualisation.docker.enable = true;

  # Nextcloud-related stuff
  ## NGINX Thing ##
  services.nginx.virtualHosts = {
    "cloud.formuna.is-a.dev" = {
      forceSSL = true;
      enableACME = true;
    };
    "vault.formuna.is-a.dev" = {
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
    hostName = "cloud.formuna.is-a.dev"; # I should get my own domain some day.

    package = pkgs.nextcloud32; # The newest version NixPKGS has right now.

    database.createLocally = true;

    configureRedis = true; # I only let a few people use this server, I'm sure it counts as "small".

    maxUploadSize = "16G"; # Literally what could you need to upload that is greater than 16GB?
    https = true; # Force HTTPS on all links

    autoUpdateApps.enable = true; # Eh why not
    extraAppsEnable = true; # Enable apps on Nextcloud startup
    extraApps = with config.services.nextcloud.package.packages.apps; {
      inherit calendar contacts mail notes;
    };

    config = {
      dbtype = "pgsql"; # Use PostgreSQL for the database.
      adminuser = "formuna";
      adminpassFile = "/etc/nextcloud-admin-pass";
    };

    settings = {
      default_phone_region = "CA";
      trusted_domains = [ "192.168.2.23" ]; # Local IP for testing
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
        DOMAIN = "https://vault.formuna.is-a.dev";
        SIGNUPS_ALLOWED = false;
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
        ROCKET_LOG = "critical";
    };
  };

  # Adguard Home
  #services.adguardhome = {
  #  enable = true;
  #  openFirewall = true;
  #  settings = {
  #    http = {
  #      # You can select any ip and port, just make sure to open firewalls where needed
  #      address = "127.0.0.1:3003";
  #    };
  #    dns = {
  #      port = 55;
  #      upstream_dns = [
  #        # Example config with quad9
  #        "9.9.9.9#dns.quad9.net"
  #        "149.112.112.112#dns.quad9.net"
  #        # Uncomment the following to use a local DNS service (e.g. Unbound)
  #        # Additionally replace the address & port as needed
  #        # "127.0.0.1:5335"
  #      ];
  #    };
  #    filtering = {
  #      protection_enabled = true;
  #      filtering_enabled = true;

  #      parental_enabled = false;  # Parental control-based DNS requests filtering.
  #    };
  #    # The following notation uses map
  #    # to not have to manually create {enabled = true; url = "";} for every filter
  #    # This is, however, fully optional
  #    filters = map(url: { enabled = true; url = url; }) [
  #      "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt"  # The Big List of Hacked Malware Web Sites
  #      "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt" # malicious url blocklist
  #    ];
  #  };
  #};

  # Kavita
  services.kavita = {
    enable = true;
    tokenKeyFile = /home/formuna/.config/tokenkeyfile;
  };

  # Code server
  services.code-server = {
    enable = true;
    disableTelemetry = true;
    auth = "none";
    host = "100.79.29.23";
  };


  system.stateVersion = "25.05"; # Don't change this value I guess.
}
