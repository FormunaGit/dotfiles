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

    kernelPackages = pkgs.linuxKernel.packages.linux_zen; # Zen kernel
    blacklistedKernelModules = [ "rtw88_8821cu" ]; # Disable this Wifi driver
  };

  # Nix-LD for binaries.
  programs.nix-ld.enable = true;

  # Add Swapfile
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 4 * 1024;
  }];

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
    firewall.allowedUDPPorts = [ 51820 ]; # WireGuard
    firewall.allowedTCPPorts = [ 2234 ]; # Nicotine+ (Soulseek)
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
      ];
    };
  };

  # ADB for controlling my phone via WIFI or USB
  programs.adb.enable = true;

  # Polkit.
  security.polkit.enable = true;

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
    enable = true;
    keyStatistics = true;
    users = [ "formuna" ];
  };

  system.stateVersion = "25.05"; # Don't change this value I guess.
}
