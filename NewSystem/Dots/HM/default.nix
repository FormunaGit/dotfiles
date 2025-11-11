{ pkgs, inputs, ... }: {
  imports = [
    ./kitty.nix # Kitty terminal
    ./nixvim # Neovim config
    ./Sway # Sway config, mainly for headless usage.
    ./WayVNC # WayVNC
  ];
}
