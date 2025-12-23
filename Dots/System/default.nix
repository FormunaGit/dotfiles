{ ... }:
{
  imports = [
    ./Copyparty # Neat file server
    ./fish.nix # Fish shell
    ./Cloudflared-Tunnels # Tunnels config (powered by systemd)
    ./MCP.nix # MCP server config
  ];
}
