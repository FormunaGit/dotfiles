{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vscodium # Code editor when Zed is broken.
    nerd-fonts.jetbrains-mono # My favorite font for coding
    rustup # Rust
    gcc # GNU's C compiler.
    godot_4 # Best game engine!
    gitkraken # I know it's closed source. And I'll keep using it till I find a better one.
    nil # --V
    nixd # Two Nix LSPs.
    nixfmt-classic # Nix file formatter
    android-studio # The Android studio.
  ];

  nixpkgs.config.android_sdk.accept_license = true; # Accept ASDK's license.

  # Enable Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Codeium Fix (yes I use AI, get over it.)
  programs.nix-ld.enable = true;

  # Services
  services.openssh.enable = true; # Enables SSH server
}
