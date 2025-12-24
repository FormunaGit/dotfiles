{ ... }:
{
  imports = [
    ./Copyparty # Neat file server
    ./fish.nix # Fish shell
    ./Cloudflared-Tunnels # Tunnels config (powered by systemd)
    ./FHS.nix # Support for LSB and FHS
    ./HomeAssistant.nix # Home Assistant
  ];
}
