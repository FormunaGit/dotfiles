{ ... }:
{
  imports = [
    ./Copyparty.nix # Neat file server
    #./UptimeKuma.nix # Uptime Kuma "config"
    ./Shell.nix # Shell config
    ./CloudflaredTunnels.nix # Tunnels config (powered by systemd)
    #./HomeAssistant.nix # Home Assistant config
    #./Syncthing.nix # Syncthing config
    ./Nix.nix # Nix config
    ./Hardware.nix # Hardware config (not to be confused with hardware-configuration)
    ./Networking.nix # Networking config
    ./Preferences.nix # System preferences
    ./Users.nix # Users config
    ./Hyprland.nix # Hyprland config
    ./ServerServices.nix # Services config
    ./Gaming.nix # Gaming stuff config
    ./Secrets.nix # Secrets management config
  ];
}
