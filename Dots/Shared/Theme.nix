# Holds a list of themes I'm using + the current one I choose for my system.
{
  lib,
  ...
}:
let
  gruvbox = {
    name = "gruvbox-dark";
    bg = "#282828";
    bg_light = "#3c3836";
    bg_lighter = "#504945";
    fg = "#ebdbb2";
    accent = "#458588";
  };
in
{
  options =
    with lib;
    with types;
    {
      currentTheme = mkOption {
        type = types.attrsOf types.str;
        default = gruvbox;
        description = "The current theme being used for the system.";
      };
    };
}
