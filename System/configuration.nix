# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
    # Import modules
    (import ./Modules/Gaming.nix { inherit pkgs; }) # Gaming module
    (import ./Modules/Stylix.nix { inherit pkgs; }) # Stylix module
    (import ./Modules/Development.nix {
      inherit pkgs;
    }) # Development tools module
    (import ./Modules/Connection.nix { inherit config; }) # Connections module
    (import ./Modules/Packages.nix { inherit pkgs inputs; }) # Packages module
  ];

  # Enable Flakes
  nix.settings = { experimental-features = [ "nix-command" "flakes" ]; };

  # Bootloader and OBS VCam
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Virtual Camera" exclusive_caps=1
  '';

  # Add Swapfile
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 4 * 1024;
  }];

  # NTFS Support
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/mnt/windows-ssd" = {
    device = "/dev/nvme0n1p3";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" ];
  };

  networking.hostName = "unimag"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "America/Moncton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Polkit
  security.polkit.enable = true;

  # Install Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
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

  # Declaratively enable Node-RED
  services.node-red = { enable = true; };

  # XDG Settings
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals =
        [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal ];
    };
  };
  environment.sessionVariables = { NIXOS_XDG_OPEN_USE_PORTAL = "1"; };

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

  # Enable Intel Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [ pkgs.intel-compute-runtime ];
  };
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
  system.stateVersion = "24.11"; # Did you read the comment?

}
