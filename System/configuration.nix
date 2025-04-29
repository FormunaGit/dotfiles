{ config, pkgs, inputs, lib, ... }:
let
  pkgs-unstable =
    inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    ./hardware-configuration.nix # Preconfigured hardware module.
    (import ./Modules/Gaming.nix { inherit pkgs; }) # Gaming module
    (import ./Modules/Stylix.nix { inherit pkgs config; }) # Stylix module
    (import ./Modules/Development.nix {
      inherit pkgs;
    }) # Development tools module
    (import ./Modules/Connection.nix {
      inherit config lib;
    }) # Connections module
    (import ./Modules/Packages.nix { inherit pkgs inputs; }) # Packages module
    (import ./Modules/Hardware.nix) # Hardware/drivers module
  ];

  # Enable Flakes and the unified Nix command.
  nix.settings = { experimental-features = [ "nix-command" "flakes" ]; };

  # Bootloader and OBS VCam settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Virtual Camera" exclusive_caps=1
  '';

  programs.nix-ld.enable = true;

  # Add Swapfile
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 4 * 1024;
  }];

  # NTFS Support (disabled for now to limit Windows usage >:I)
  # boot.supportedFilesystems = [ "ntfs" ];
  # fileSystems."/mnt/windows-ssd" = {
  #   device = "/dev/nvme0n1p3";
  #   fsType = "ntfs-3g";
  #   options = [ "rw" "uid=1000" ];
  # };

  # Also mount my external SS(H)D..?
  fileSystems."/run/media/formuna/Gamerson" = {
    device = "/dev/sda1";
    fsType = "btrfs";
    options = [
      "users"
      "rw"
      "exec" # Required for steam
    ]; # ^ Also place "nofail" if required, right now I'm okay with having to plug it in each time.
  };

  # Defines hostname.
  networking.hostName = "unimag"; # Define your hostname.

  # Sets timezone.
  time.timeZone = "America/Moncton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enables the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment and SDDM.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Defines the "formuna" account. (thats me :D)
  users.users.formuna = {
    isNormalUser = true;
    description = "Formuna";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "scanner"
      "lp"
      "docker"
      "uinput"
      "kvm"
    ];
  };
  # Install firefox.
  programs.firefox.enable = true; # Todo: replace this with Floorp soon :3

  # Allow unfree packages because...
  nixpkgs.config.allowUnfree = true;

  # Enable Polkit
  security.polkit.enable = true;

  # Install Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    # Configure Hyprland to use the flake packages
    package = pkgs-unstable.hyprland;
    portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
  };

  # Fix weird bug where Blender/games are slow
  hardware.graphics = {
    enable = true;
    package = pkgs-unstable.mesa;
    enable32Bit = true; # Enable 32-bit
    package32 = pkgs-unstable.pkgsi686Linux.mesa;
  };

  # Enable WireGuard
  networking.firewall = {
    allowedUDPPorts = [ 51820 3000 ];
    allowedTCPPorts = [ 3000 ];
  };
  networking.wireguard.enable = true;
  services.resolved.enable = true;

  # Enable Flatpak
  services.flatpak.enable = true;

  # Enable ZSH (Configuration in home manager)
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    enableLsColors = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "robbyrussell";
    };
  };
  users.defaultUserShell = pkgs.zsh;

  # Enable Tailscale
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  # Enable Auto-CPUFREQ
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  # Add GIMP printing support
  nixpkgs.config.packageOverrides = pkgs: {
    xsaneGimp = pkgs.xsane.override { gimpSupport = true; };
  };

  # Enable Virt-Manager
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "formuna" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # Declaratively enable DCONF
  programs.dconf = { enable = true; };

  # XDG Settings
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-gtk pkgs-unstable.xdg-desktop-portal-hyprland ];
    };
  };
  #environment.sessionVariables = { NIXOS_XDG_OPEN_USE_PORTAL = "1"; };

  # Weylus.
  programs.weylus = {
    enable = true;
    openFirewall = true;
    users = [ "formuna" ];
  };

  # Stop the power button from being used to shut off the computer.
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

  # Install a Polkit authentication agent
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

  # Enable Input Remapper
  services.input-remapper = {
    enable = true;
    enableUdevRules = true;
  };

  # Enable OpenRAZER
  hardware.openrazer = {
    enable = true;
    keyStatistics = true;
    users = [ "formuna" ];
    syncEffectsEnabled = true;
  };

  # Enable Emacs
  services.emacs = { # Enable the server
    enable = true;
    package = pkgs.emacs30-gtk3; # I like GTK.
  };

  # Enable Waydroid
  virtualisation.waydroid.enable = true;

  # Enable Fish
  programs.fish.enable = true;
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # }

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 3000 ];
  # networking.firewall.allowedUDPPorts = [ 3000 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
