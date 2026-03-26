{ ... }:
{
  imports = [
    ./Copyparty.nix # Neat file server
    ./Shell.nix # Shell config
    ./CloudflaredTunnels.nix # Tunnels config (powered by systemd)
    ./Nix.nix # Nix config
    ./Hardware.nix # Hardware config (not to be confused with hardware-configuration)
    ./Networking.nix # Networking config
    ./Preferences.nix # System preferences
    ./Users.nix # Users config
    ./ServerServices.nix # Services config
    ./Gaming.nix # Gaming stuff config
    ./Secrets.nix # Secrets management config
    ./Fonts.nix # Fonts config
    ./COSMIC.nix # COSMIC config
    ./Podman.nix # Podman config
  ];
}
