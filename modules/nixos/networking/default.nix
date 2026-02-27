{ ... }:
{
  networking = {
    hostName = "unimag"; # System hostname
    networkmanager.enable = true; # Enable Wi-Fi

    firewall = {
      allowedUDPPorts = [
        51820 # Wireguard
        443 # HTTPS
        25565 # MC Java
        19132 # MC Bedrock
      ];

      allowedTCPPorts = [
        80 # HTTP
        443 # HTTPS
        25565 # MC Java
        19132 # MC Bedrock
      ];
    };

    # WireGuard
    wireguard.enable = true;
  };

  # The systemd DNS resolver
  services.resolved.enable = true;
}
