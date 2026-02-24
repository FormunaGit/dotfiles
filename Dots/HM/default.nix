{ ... }:
{
  imports = [
    ./Kitty.nix # Kitty terminal
    ./Hypr # Hyprland config
    ./Neovim.nix # Nixvim config (kickstart.nixvim)
    ./Zellij.nix # Zellij config
    ./DarkMode.nix # Dark mode for the system
    ./Discord.nix # Nixcord config
    ./Noctalia # Noctalia Config
  ];
}
