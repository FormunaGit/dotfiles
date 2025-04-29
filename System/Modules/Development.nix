{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nerd-fonts.jetbrains-mono # My favorite font for coding
    rustup # Rust
    gcc # GNU's C compiler.
    godot_4 # Best game engine!
    gitkraken # I know it's closed source. And I'll keep using it till I find a better one.
    nixd # Useful Nix LSP.
    nixfmt-classic # Nix file formatter
  ];
  
  # Services
  services.openssh.enable = false; # Enables SSH server, currently disabled
}
