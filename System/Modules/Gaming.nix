{ pkgs, ... }: {
  programs.steam = { # The closed source #1 game launcher.
    enable = true; # Enable Steam
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
    protontricks.enable = true; # Install Winetricks fork made for Steam.
  };

  environment.systemPackages = with pkgs; [
    # Game Tools
    lutris # Open-source all-in-one game launcher.
    wineWowPackages.stable # Windows app compatibility layer with beta 64-bit support.
    prismlauncher # Custom Minecraft launcher.
    winetricks # Script for managing Wine configs.
    overlayed # Open-source Discord overlay.
  ];
}
