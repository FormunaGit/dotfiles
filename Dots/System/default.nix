{ ... }:
{
  imports = [
    ./Copyparty # Neat file server
    ./fish.nix # Fish shell
    ./Cloudflared-Tunnels # Tunnels config (powered by systemd)
    ./HomeAssistant.nix # Home Assistant
    ./Syncthing.nix # Syncthing config
  ];
}
