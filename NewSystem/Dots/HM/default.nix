{ pkgs, inputs, ... }: {
  imports = [
    ./kitty.nix # Kitty terminal
    ./nixvim # Neovim config
  ];
}
