{ pkgs, config, ... }:
let
  github-dark-base16 = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/tinted-theming/schemes/refs/heads/spec-0.11/base16/github-dark.yaml";
    sha256 = "1sylsjd92f81nabg01mfbpv9bq79bkzxm3bjwkbds583wz6vpdi8";
  };
in{
  # Stylix
  stylix = {
    enable = true;
    autoEnable = true;
    image = ../Wallpapers/escape_velocity_small.png;
    base16Scheme = github-dark-base16;
    polarity = "dark";
    fonts = {
      serif = config.stylix.fonts.sansSerif;
      sansSerif = {
        package = pkgs.quicksand;
        name = "Quicksand";
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
