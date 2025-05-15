{ config, pkgs, inputs, ... }:
let
  hyprpkgs =
    inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  kernelpkgs = config.boot.kernelPackages;
in {
  imports = [
    ./hardware-configuration.nix # System's preconfigured hardware module.
    (import ./Packages.nix { inherit pkgs inputs; }) # System Packages.
    (import ./Stylix.nix { inherit pkgs config; }) # Stylix.
  ];

  # Enable Flakes and the unified Nix command.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader and OBS VCam settings
  boot = {
    loader = {
      systemd-boot.enable = true; # Systemd-boot. Simple.
      efi.canTouchEfiVariables = true;
    };
    extraModulePackages = with kernelpkgs; [ v4l2loopback ]; # Kernel modules
    kernelModules = [ "v4l2loopback" ]; # Activate(?) kernel modules
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS VCAM" exclusive_caps=1
    '';
  };

  # Nix-LD for binaries.
  programs.nix-ld.enable = true;

  # Add Swapfile | TODO: Lower this to 2GB some day.
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 4 * 1024;
  }];

  # Mount external SSD.
  fileSystems."/run/media/formuna/PreNiles" = {
    device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "users" "rw" "exec" ];
  };

  # Networking stuff + set the system hostname.
  networking = {
    hostName = "unimag"; # System Hostname
    firewall.allowedUDPPorts =
      [ 51820 ]; # Currently only WireGuard port is opened.
    networkmanager.enable = true; # Enable NetworkManager since I need Wi-Fi.
  };
  services.resolved.enable = true; # The systemd DNS resolver daemon.

  # Speaking of which, WireGuard!
  networking.wireguard.enable = true;

  # And then Tailscale!
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client"; # My PC isn't server.
    openFirewall = true; # Opens port in firewall.
  };

  # Bluetooth stuff
  hardware.bluetooth.enable = true;
  services.blueman.enable = true; # A GUI for managing Bluetooth devices

  # My timezone.
  time.timeZone = "America/Moncton";

  # Set "internationalisation properties"
  i18n.defaultLocale = "en_CA.UTF-8";

  # Install ReGreet as an alternative to SDDM.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable sound with Pipewire (plus some backwards compatibility)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # #########################
    alsa.enable = true; # Enable backwards       #
    alsa.support32Bit = true; # compatibility with the #
    pulse.enable = true; # weaker audio systems.  #
  }; # #########################

  # Define the "formuna" user account. (that's me!)
  users = {
    defaultUserShell = pkgs.fish; # Sets Fish as the default shell.
    users.formuna = {
      isNormalUser = true; # Says this account is a human's account.
      description = "Formuna"; # The human readable name of the user.
      extraGroups = [
        "networkmanager" # Control over NetworkManager
        "wheel" # Sudo privs
        "adbusers" # Access to sudo-less ADB
        "scanner" # Control over scanners ⟵┬{Printer-related groups}
        "lp" # Control over printers ⟵╯
        "uinput" # Not sure what this is for, but if it ain't broke...
        "kvm" # Control over KVM-powered VMs
      ];
    };
  };

  # ADB for controlling my phone via WIFI or USB
  programs.adb.enable = true;

  # Allow non-FOSS packages.
  nixpkgs.config.allowUnfree = true;

  # Polkit.
  security.polkit.enable = true;

  # Small system-wide Hyprland config.
  programs.hyprland = {
    enable = true;
    withUWSM = true; # "Improves systemd support" by using UWSM. Why not.
    xwayland.enable = true; # Enables xWayland.           ###################
    package = hyprpkgs.hyprland; # Use updated     #
    portalPackage = hyprpkgs.xdg-desktop-portal-hyprland; # flake packages. #
  }; # ##################

  # Also set some XDG settings.
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        hyprpkgs.xdg-desktop-portal-hyprland
      ];
    };
  };

  hardware.graphics = {
    enable = true; # No idea why this isn't enabled by default...
    enable32Bit = true; # 32-Bit drivers.
    package = hyprpkgs.mesa; # 64-bit ⟵┬{Mesa drivers from HyprCachix}
    package32 = hyprpkgs.pkgsi686Linux.mesa; # 32-bit ⟵╯
    extraPackages = with pkgs; [ intel-media-driver ]; # 64b ⟵╮
    extraPackages32 = with pkgs.pkgsi686Linux; [ intel-media-driver ]; # 32b ⟵┤
  }; # {Intel Drivers}╯

  # Power-related features (Auto-CPUFREQ+Thermald)
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      }; # Save when on battery
      charger = {
        governor = "performance";
        turbo = "auto";
      }; # Go full when charging
    };
  };

  # Not sure where I need this, but here's dConf.
  programs.dconf.enable = true;

  # Weylus for using my phone as a stylus.
  programs.weylus = {
    enable = true;
    openFirewall = true; # Needed for accessing the webpage from my phone.
    users = [ "formuna" ]; # Needed for accessing Weylus without root.
  };

  # Stop the power button from being used to shut off the computer.
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

  # Polkit stuff
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Input remapper for remapping inputs.
  services.input-remapper = {
    enable = true;
    enableUdevRules = true;
  };

  # Enable fish
  programs.fish.enable = true;

  system.stateVersion = "25.05"; # Don't change this value I guess.

  # ╔────────────╗ #
  # │Gaming Stuff│ #
  # ╚────────────╝ #
  programs.steam = { # The best game launcher.
    enable = true;
    dedicatedServer.openFirewall = true; # Open firewall for servers.
    protontricks.enable = true; # Valve-flavored Winetricks.
    extraCompatPackages = [ pkgs.proton-ge-bin ]; # ProtonGE.
  };

  # Flatpak!
  services.flatpak.enable = true;
}
