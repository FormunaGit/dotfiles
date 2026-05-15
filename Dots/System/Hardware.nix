{
  # inputs,
  pkgs,
  ...
}:
let
  swapsize = 2;
in
{
  # Boot configuration
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot.enable = true; # EFI boot manager
      efi.canTouchEfiVariables = true; # Already had this enabled
    };
  };

  # Swapfile configuration
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = swapsize * 1024; # Size is in megabytes
    }
  ];

  # OBS Vcam
  programs.obs-studio.enableVirtualCamera = true;

  # Graphics configuration
  # hardware.graphics = {
  #   package = hyprPackages.mesa; # Use Hyprland's Mesa package
  #   package32 = hyprPackages.pkgsi686Linux.mesa; # 32-bit support
  #   enable32Bit = true;
  # };

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
