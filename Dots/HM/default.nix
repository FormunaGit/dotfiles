{ ... }:
{
  imports = [
    ./Kitty.nix # Kitty terminal
    ./Hypr # Hyprland config
    ./Neovim.nix # Nixvim config (kickstart.nixvim)
    ./Zellij.nix # Zellij config
    #./MCP.nix # MCP server config
  ];
}
