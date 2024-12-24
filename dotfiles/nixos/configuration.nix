# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader and OBS VCam
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  # Add Swapfile
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 8*1024;
  } ];

  # Install Lix
  nix.package = pkgs.lix;

  networking.hostName = "unimag"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Configure Sudo
  security.sudo = {
    enable = true;
    extraRules = [{
      commands = [
        {
          command = "/home/formuna/home-manager/scripts/quicksudos/clean.sh";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/home/formuna/home-manager/scripts/quicksudos/upgrade.sh";
          options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }];
  };

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Enable CUPS to print documents + add autodiscovery + scanner support
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  hardware.sane.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # NTFS Support
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/mnt/windows-ssd" =
  { device = "/dev/nvme0n1p3";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000"];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.formuna = {
    isNormalUser = true;
    description = "Formuna";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "scanner" "lp"];
    packages = [];
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

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  
  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    protontricks.enable = true;
  };

  # Enable WireGuard
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };
  networking.wireguard.enable = true;
  services.resolved.enable = true;
  
  # Enable Flatpak
  services.flatpak.enable = true;
  
  # Enable Waydroid and ADB
  virtualisation.waydroid.enable = true;
  programs.adb.enable = true;
  
  # Enable ZSH (Configuration in home manager)
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;

    ohMyZsh = {
      enable = true;
      plugins = ["git" "sudo"];
      theme = "robbyrussell";
    };
  };
  users.defaultUserShell = pkgs.zsh; 
  
  # Enable Tailscale
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  # Codeium Fix (yes I use AI, get over it.)
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [];
  
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
  programs.dconf = {
    enable = true;
  };

  # Declaratively enable Node-RED
  services.node-red = {
    enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    qemu
    quickemu
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
