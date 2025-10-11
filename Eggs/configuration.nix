{ config, pkgs, inputs, ... }: 
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
  };
  services.resolved.enable = true; # The systemd DNS resolver daemon.

  # And then Tailscale!
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both"; # This is dor.
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

  # NUR!!
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball
      "https://github.com/nix-community/NUR/archive/main.tar.gz") {
        inherit pkgs;
      };
  };

  # SSH configuration
  services.openssh = {
    enable = true; # Enable SSH
    ports = [ 22 ]; # Use the default port
    settings = {
      PermitRootLogin = "no"; # Disable root login
      AllowUsers = [ "formuna" ]; # Only allow my account
    };
  };
  services.fail2ban.enable = true; # Enable fail2ban so if someone tries to guess my password...

  # XFCE
  services.xserver.desktopManager.xfce.enable = true;

  # System Packages, soon to be moved into its own module.
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    curl
    ripgrep
    btop
  ];

  # Nextcloud. Inaccessible outside my Tailnet.
  # services.nextcloud = {
  #   enable = true;
  #   hostName = "eggs.tarpan-owl.ts.net";
  #   config = {
  #     adminpassFile = "/etc/nextcloud-admin-pass";
  #     dbtype = "pgsql";
  #   };
  # };
  # services.nextcloud = {
  #   enable = true;
  #   package = pkgs.nextcloud31;
  #   hostName = "localhost";
  #   database.createLocally = true;
  #   configureRedis = true;
  #   config = {
  #     adminuser = "formuna";
  #     adminpassFile = "/etc/nextcloud-admin-pass";
  #     dbtype = "mysql";
  #   };
  #   settings = {
  #     default_phone_region = "US";
  #     # mail_smtpmode = "sendmail";
  #     # mail_sendmailmode = "pipe";
  #     mysql.utf8mb4 = true;
  #     trusted_proxies = [
  #       "127.0.0.1"
  #       "100.106.83.119"
  #       "eggs.tarpan-owl.ts.net"
  #       "10.0.0.230"
  #     ];
  #   };
  #   maxUploadSize = "2G"; # also sets post_max_size and memory_limit
  #   phpOptions = {
  #     "opcache.interned_strings_buffer" = "16";
  #   };
  # };

  # Docker
  virtualisation.docker = {
    enable = true;
  };

  # Tailscale Serve Nextcloud systemd service
  systemd.user.services.my-cool-user-service = {
    enable = true;
    # [Unit]
    description = "Serve Nextcloud backend through Tailscale";
    after = [ "network.target" ];
    # [Service]
    serviceConfig = {
        Type = "oneshot";
        ExecStart = "/usr/bin/bash -c 'tailscale serve --bg http://127.0.0.1:11000'";
    };
    # [Install]
    wantedBy = [ "multi-user.target" ];
  };

  system.stateVersion = "25.05"; # Don't change this value I guess.
}
