# Holds a list of themes I'm using + the current one I choose for my system.
{ lib, pkgs, ... }:
let
  themes = {
    gruvbox_material = {
      name = "Gruvbox Material";
      name_kitty = "GruvboxMaterialDarkMedium";
      name_nvim = "gruvbox-material-dark-medium";
      base16 = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/MayushKumar/base16-gruvbox-material-scheme/refs/heads/master/gruvbox-material-dark-medium.yaml";
      };
    };

    macchiato = {
      name = "Catppuccin Macchiato";
      name_kitty = "Catppuccin-Macchiato";
      name_nvim = "catppuccin-macchiato";
      base16 = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/base16/refs/heads/main/base16/macchiato.yaml";
      };
    };

    template = {
      name = "";
      name_kitty = "";
      name_nvim = "";
      base16 = "";
    };
  };
in
{
  options =
    with lib;
    with types;
    {
      currentTheme = mkOption {
        #type = types.attrsOf types.str;
        default = themes.gruvbox_material;
        description = "The current theme being used for the system.";
      };
    };

}
