{ pkgs, config, ... }: 
{
  imports = [ 
    ./hardware-configuration.nix # System's preconfigured hardware module.
  ];

  # Allow non-FOSS packages.
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes and the unified Nix command.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader and OBS VCam settings
  boot.loader = {
    systemd-boot.enable = true; # Systemd-boot. Simple.
    efi.canTouchEfiVariables = true;
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

  # Networking stuff + set the system hostname.
  networking = {
    hostName = "eggs"; # System Hostname
    networkmanager.enable = true; # Enable NetworkManager since I need Wi-Fi.
    firewall.allowedUDPPorts = [ 443 3478 25565 25575 ]; # Stuff
    firewall.allowedTCPPorts = [ 8080 80 8443 443 3478 25565 25575 80 443 ]; 
  };
  services.resolved.enable = true; # The systemd DNS resolver daemon.

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
        "docker" # For Docker
      ];
    };
  };

  # Polkit.
  security.polkit.enable = true;

  # Enable fish
  programs.fish.enable = true;

  # And enable Starship
  programs.starship = {
    enable = true;
    # Additional configuration options can be added here.
  };

  # SSH configuration
  services.openssh = {
    enable = true; # Enable SSH
    ports = [ 2222 ]; # Use a new port
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no"; # Disable root login
      AllowUsers = [ "formuna" ]; # Only allow my account
    };
  };
  services.fail2ban.enable = true; # Enable fail2ban so if someone tries to guess my password...
  services.endlessh = { # Why not?
    enable = true;
    port = 22;
    openFirewall = true;
  };

  # System Packages, soon to be moved into its own module.
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    curl
    ripgrep
    btop
    nh
    gh
    caddy
    lazygit
    kitty
  ];

  # Docker
  virtualisation.docker.enable = true;

  # Nextcloud and related
  services.nginx.virtualHosts = {
    "cloud.formuna.is-a.dev" = {
      forceSSL = true;
      enableACME = true;
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = (builtins.readFile /etc/my-email);
  };

  services.nextcloud = {
    enable = true;
    hostName = "cloud.formuna.is-a.dev";

    package = pkgs.nextcloud32;

    database.createLocally = true;

    configureRedis = true;

    maxUploadSize = "16G";
    https = true;

    autoUpdateApps.enable = true;
    extraAppsEnable = true;
    extraApps = with config.services.nextcloud.package.packages.apps; {
      inherit calendar contacts mail notes;
    };

    config = {
      #overwriteProtocol = "https";
      dbtype = "pgsql";
      adminuser = "formuna";
      adminpassFile = "/etc/nextcloud-admin-pass";
    };
    settings = {
      default_phone_region = "CA";
      trusted_domains = [ "192.168.2.27" ];
    };
  };

  system.stateVersion = "25.05"; # Don't change this value I guess.
}
