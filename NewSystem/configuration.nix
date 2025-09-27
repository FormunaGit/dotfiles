{ config, pkgs, inputs, ... }:
let
  hyprpkgs =
    inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    ./Modules/hardware-configuration.nix # System's preconfigured hardware module.

    #./Modules/Hydenix/System
    (import ./Modules/Packages.nix { inherit pkgs inputs; }) # System Packages.
    (import ./Modules/Stylix.nix) # Stylix.
    (import ./Modules/Minecraft.nix { inherit pkgs inputs; })
    ./Modules/MicOverMumble.nix
  ];

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
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Virtual Camera" exclusive_caps=1
    ''; # OBS Virtual Camera settings

    kernelPackages = pkgs.linuxKernel.packages.linux_zen; # Zen kernel
    blacklistedKernelModules = [ "rtw88_8821cu" ];
  };

  # Nix-LD for binaries.
  programs.nix-ld.enable = true;

  # Add Swapfile
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 4 * 1024;
  }];

  # Mount secondary SSD.
  fileSystems."/run/media/formuna/StrangeDrive" = {
    device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "users" "rw" "exec" ];
  };

  # Hardware accelerated graphics drivers?
  # hardware.graphics = {
  #   enable = true;
  #   enable32Bit = true;
  # };
  hardware.graphics = {
    package = hyprpkgs.mesa;

    # if you also want 32-bit support (e.g for Steam)
    enable32Bit = true;
    package32 = hyprpkgs.pkgsi686Linux.mesa;
  };

  # Networking stuff + set the system hostname.
  networking = {
    hostName = "unimag"; # System Hostname
    networkmanager.enable = true; # Enable NetworkManager since I need Wi-Fi.
    # enableIPv6 = false;
    firewall.allowedUDPPorts = [ 51820 59100 ];
    firewall.allowedTCPPorts = [ 59100 2234 ];
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
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable Mumble server for mic_over_mumble
  services.murmur = {
    enable = false;
    bandwidth = 540000;
    bonjour = true;
    password = "thisMumbleServerIsntAccesibleThroughTheInternet!!";
    autobanTime = 0;
  };

  # Define the "formuna" user account. (that's me!)
  users = {
    defaultUserShell = pkgs.fish; # Sets Fish as the default shell.
    users.formuna = {
      isNormalUser = true; # Says this account is a human's account.
      description = "Formuna"; # The human readable name of the user.
      extraGroups = [
        "networkmanager" # Control over NetworkManager
        "wheel" # Sudo privileges
        "adbusers" # Access to sudo-less ADB
        "uinput" # Not sure what this is for, but if it ain't broke...
        "kvm" # Control over KVM-powered VMs
        "video" # For display/graphics access
      ];
    };
  };

  # ADB for controlling my phone via WIFI or USB
  programs.adb.enable = true;

  # Allow non-FOSS packages.
  nixpkgs.config.allowUnfree = true;

  # Polkit.
  security.polkit.enable = true;

  # Power-related features (PPD for control in GNOME)
  services.power-profiles-daemon.enable = true;

  # Weylus for using my phone as a stylus.
  programs.weylus = {
    enable = true;
    openFirewall = true; # Needed for accessing the webpage from my phone.
    users = [ "formuna" ]; # Needed for accessing Weylus without root.
  };

  # Input remapper for remapping inputs.
  services.input-remapper = {
    enable = true;
    enableUdevRules = true;
  };

  # TODO: Fix printing.
  
  # Forgot to leave GDM installed... Oh well, I always wanted to try a new DM.
  services.displayManager.ly.enable = true;
  # Enable GDM+GNOME
  # oh yeah also some GNOME configs, dconf and gsconnect
  # services.displayManager.gdm.enable = true;
  # services.desktopManager.gnome.enable = true;
  # programs.dconf.enable = true;
  # programs.kdeconnect = {
  #   enable = true;
  #   package = pkgs.gnomeExtensions.gsconnect;
  # };

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
    package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # OpenRazer
  hardware.openrazer = {
    enable = true;
    keyStatistics = true;
    users = [ "formuna" ];
  };

  # Probably insecure. Docker.
  virtualisation.docker = { enable = false; };

  system.stateVersion = "25.05"; # Don't change this value I guess.
}
