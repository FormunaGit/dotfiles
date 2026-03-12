{
  inputs,
  config,
  pkgs,
  ...
}:
let
  kernelPackages = config.boot.kernelPackages;
  hyprPackages = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  swapsize = 1;
in
{
  # Boot configuration
  boot = {
    loader = {
      systemd-boot.enable = true; # EFI boot manager
      efi.canTouchEfiVariables = true; # Already had this enabled
    };

    # Disable certain modules (currently for a WiFi card)
    blacklistedKernelModules = [ "rtw88_8821cu" ];
  };

  # Swapfile configuration
  # TODO: Make the swapfile size change with the maximum RAM
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = swapsize * 1024; # Size is in megabytes
    }
  ];

  # OBS Vcam
  programs.obs-studio.enableVirtualCamera = true;

  # Graphics configuration
  hardware.graphics = {
    package = hyprPackages.mesa; # Use Hyprland's Mesa package
    package32 = hyprPackages.pkgsi686Linux.mesa; # 32-bit support
    enable32Bit = true;
  };

  # Allow all firmware regardless of license
  hardware.enableAllFirmware = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;

  # Pipewire configuration
  security.rtkit.enable = true; # Used by Pipewire
  services.pipewire = {
    enable = true; # Enable Pipewire
    alsa.enable = true; # Enable ALSA support
    alsa.support32Bit = true; # ^^^
    pulse.enable = true; # Enable Pulseaudio support
    jack.enable = true; # Enable JACK support
  };

  # Printer and scanner
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };

  hardware.sane.enable = true;

  # Power Profiles Daemon
  services.power-profiles-daemon.enable = true;
}
