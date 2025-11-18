{ ... }: {
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    themeFile = "gruvbox-dark";
    settings = {
      cursor_trail = 1;
      font_family = "MonaspiceAr Nerd Font Mono";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
    };
  };
}
