{ ... }:
{
  imports = [
    ./Kitty.nix # Kitty terminal
    ./Neovim.nix # Nixvim config (kickstart.nixvim)
    ./Zellij.nix # Zellij config
    ./DarkMode.nix # Dark mode for the system
    ./DE.nix # Desktop environment config
  ];
}
