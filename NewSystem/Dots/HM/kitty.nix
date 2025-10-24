{ ... }: let
  gruvbox = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/kovidgoyal/kitty-themes/refs/heads/master/themes/gruvbox-dark.conf";
    sha256 = "1yhaygavylmx6nypp2p27449fs4qkml66m82gm1y1rgxagm64w9w";
  };
in
{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    settings = {
      cursor_trail = 1;
      font_family = "MonaspiceAr Nerd Font Mono";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
    };
  };
}
