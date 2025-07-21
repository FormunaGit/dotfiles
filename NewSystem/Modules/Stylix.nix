{ ... }:
let
  tokyo-night-base16 = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/viniciusmuller/base16-tokyonight-scheme/refs/heads/master/tokyonight.yaml";
    sha256 = "0hy93xlrzkjwn2qqlmrwgclj5cyxhw5rrlz8h057ra3qdpx2s8kh";
  };
  wallpaper = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/D3Ext/aesthetic-wallpapers/main/images/nix.png";
    sha256 = "1lbp4j3jwm8xjpnwz9amwwpkc1s60b9ll4mv845gis25ay8y410p";
  };
in {
  # Stylix
  stylix = {
    enable = true;
    autoEnable = true;
    image = wallpaper;
    base16Scheme = tokyo-night-base16;
    polarity = "dark";
    # fonts = {
    #   serif = config.stylix.fonts.sansSerif;
    #   sansSerif = {
    #     package = pkgs.quicksand;
    #     name = "Quicksand";
    #   };
    #   monospace = {
    #     package = pkgs.nerd-fonts.jetbrains-mono;
    #     name = "JetBrains Mono Nerd Font";
    #   };
    #   emoji = {
    #     package = pkgs.noto-fonts-emoji;
    #     name = "Noto Color Emoji";
    #   };
    # };
  };
}
