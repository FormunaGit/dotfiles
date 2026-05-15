{ ... }:
{
  networking = {
    hostName = "unimag"; # System hostname
    networkmanager.enable = true; # Enable Wi-Fi

    firewall = {
      allowedUDPPorts = [
        51820 # Wireguard
        25565 # MC Java
        19132 # MC Bedrock
        6567 # Mindustry Server
      ];

      allowedTCPPorts = [
        25565 # MC Java
        19132 # MC Bedrock
        6567 # Mindustry Server
      ];
    };

    # WireGuard
    wireguard.enable = true;
  };

  # The systemd DNS resolver
  services.resolved.enable = true;
}
