{ config, pkgs, inputs, nixvim, ... }:
let kernelpkgs = config.boot.kernelPackages;
in {
  imports = [
    ./Modules/hardware-configuration.nix # System's preconfigured hardware module.
    (import ./Modules/Packages.nix { inherit pkgs inputs; }) # System Packages.
    (import ./Modules/Stylix.nix) # Stylix.
    (import ./Modules/Nixvim.nix { inherit pkgs nixvim; }) # Nixvim.
    #./MicOverMumble.nix
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

    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };

  # Nix-LD for binaries.
  programs.nix-ld.enable = true;

  # Add Swapfile | TODO: Lower this to 2GB some day.
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 6 * 1024;
  }];

  # Mount external SSD. Disabled because the drive is no longer used.
  # fileSystems."/run/media/formuna/PreNiles" = {
  #   device = "/dev/sda1";
  #   fsType = "btrfs";
  #   options = [ "users" "rw" "exec" ];
  # };

  # Networking stuff + set the system hostname.
  networking = {
    hostName = "unimag"; # System Hostname
    firewall.allowedUDPPorts = [
      51820 # WireGuard port
      #64738 # Mumble server port
    ];
    #firewall.allowedTCPPorts = [ 64738 ];
    networkmanager = { # Enable NetworkManager since I need Wi-Fi.
      enable = true;
      wifi.powersave = false;
    };
    enableIPv6 = false;
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
  #services.blueman.enable = true; # A GUI for managing Bluetooth devices

  # My timezone.
  time.timeZone = "America/Moncton";

  # Set "internationalisation properties"
  i18n.defaultLocale = "en_CA.UTF-8";

  # Install ReGreet as an alternative to SDDM.
  #services.displayManager.sddm.enable = true;
  #services.desktopManager.plasma6.enable = true;

  # Enable sound with Pipewire (plus some backwards compatibility)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable Mumble server for mic_over_mumble
  #services.murmur = {
  #  enable = true;
  #  bandwidth = 540000;
  #  bonjour = true;
  #  password = "thisMumbleServerIsntAccesibleThroughTheInternet!!";
  #  autobanTime = 0;
  #};

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
        "lp" # Control over printers      ⟵╯
        "uinput" # Not sure what this is for, but if it ain't broke...
        "kvm" # Control over KVM-powered VMs
        "render"
        "video"
        "libvirtd"
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
  # programs.hyprland = {
  #   enable = true;
  #   withUWSM = true; # "Improves systemd support" by using UWSM. Why not.
  #   xwayland.enable = true; # Enables xWayland.           ###################
  #   package = hyprpkgs.hyprland; # Use updated     #
  #   portalPackage = hyprpkgs.xdg-desktop-portal-hyprland; # flake packages. #
  # }; # ##################

  # Also set some XDG settings.
  # Not sure if this is needed.
  # xdg = {
  #   autostart.enable = true;
  #   portal = {
  #     enable = true;
  #     extraPortals = with pkgs; [ xdg-desktop-portal xdg-desktop-portal-gtk ];
  #   };
  # };

  # Not sure if this is needed.
  hardware.graphics = {
    enable = true; # No idea why this isn't enabled by default...
    enable32Bit = true; # 32-Bit drivers.
    extraPackages = with pkgs; [ intel-media-driver vpl-gpu-rt ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ intel-media-driver ];
  };

  # Power-related features (Auto-CPUFREQ+Thermald)
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = { # Save when on battery
        governor = "powersave";
        turbo = "never";
      };
      charger = { # Go ALL OUT when charging
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  # Weylus for using my phone as a stylus.
  programs.weylus = {
    enable = true;
    openFirewall = true; # Needed for accessing the webpage from my phone.
    users = [ "formuna" ]; # Needed for accessing Weylus without root.
  };

  # Stop the power button from being used to shut off the computer,
  # and make closing the lid not cause the both screens to shut off.
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=ignore
  '';

  # Input remapper for remapping inputs.
  services.input-remapper = {
    enable = true;
    enableUdevRules = true;
  };

  # Enable printing and scanning
  services.printing.enable = true;
  hardware.sane.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable GDM+GNOME
  # oh yeah also some GNOME configs, dconf and gsconnect
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs.gnomeExtensions; [
    appindicator # Tray icons
    blur-my-shell # Blur the shell.
    burn-my-windows # KABOOOM my windows
    dash-to-dock
    desktop-cube # Haven't used this in a while
    forge # The WM.
    kando-integration # Cool launcher
    pano # Clipboard manager
    runcat # Funny cat that runs
    space-bar # i3-like bar
    tweaks-in-system-menu # system menu tweaks
  ];
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

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

  # Waydroid (Disabled for now due to update being broken)
  #virtualisation.waydroid.enable = true;

  # QEMU/KVM
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
  programs.virt-manager.enable = true;

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
  services.flatpak = {
    enable = true;
    packages = [
      "com.github.tchx84.Flatseal"
      "org.vinegarhq.Sober"
      "org.vinegarhq.Vinegar"
      "dev.overlayed.Overlayed"
      # GNOME-related stuff
      "com.rafaelmardojai.Blanket"
      "org.gnome.Builder"
      "com.github.wwmm.easyeffects"
      "org.gnome.Boxes"
      "org.godotengine.Godot"
    ];
  };

  system.stateVersion = "25.05"; # Don't change this value I guess.
}
