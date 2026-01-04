{ ... }:
{
  imports = [
    ./Kitty.nix # Kitty terminal
    ./Hypr # Hyprland config
    ./Neovim.nix # Nixvim config (kickstart.nixvim)
    ./Zellij.nix # Zellij config
    ./Ignis.nix # Ignis config
    ./DarkMode.nix # Dark mode for the system
    ./Discord.nix # Nixcord config
  ];
}
