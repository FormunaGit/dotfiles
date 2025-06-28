{ ... }:
let
  rose-pine-base16 = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/edunfelt/base16-rose-pine-scheme/refs/heads/main/rose-pine.yaml";
    sha256 = "1qwd70fiqd321jhbbc6y4313r37h4mjb8a208i5d6prmns0y25jd";
  };
  wallpaper = builtins.fetchurl {
    url = "https://w.wallhaven.cc/full/8o/wallhaven-8ogv6k.jpg";
    sha256 = "0lnql6pqky6nichm6i41rq0dk4h7rbyix7lxpnpbgfs9gisq6xv2";
  };
in {
  # Stylix
  stylix = {
    enable = true;
    autoEnable = true;
    image = wallpaper;
    base16Scheme = rose-pine-base16;
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
