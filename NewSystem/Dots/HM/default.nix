{ pkgs, inputs, ... }: {
  imports = [
    ./kitty.nix # Kitty terminal
    ./nixvim.nix # Neovim config
  ];
}
