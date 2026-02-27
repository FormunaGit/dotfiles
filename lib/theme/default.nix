# Holds a list of themes I'm using + the current one I choose for my system.
{ lib, ... }:
let
  themes = {
    gruvbox_material = {
      name = "Gruvbox Material";
      name_kitty = "GruvboxMaterialDarkMedium";
      name_nvim = "gruvbox-material-dark-medium";
      base16 = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/MayushKumar/base16-gruvbox-material-scheme/refs/heads/master/gruvbox-material-dark-medium.yaml";
        sha256 = "11k4xg5f8zrlx0kmpc8d7zkdmgddawygmcdk37g67pdhb2p5dmrf";
      };
    };

    macchiato = {
      name = "Catppuccin Macchiato";
      name_kitty = "Catppuccin-Macchiato";
      name_nvim = "catppuccin-macchiato";
      base16 = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/base16/refs/heads/main/base16/macchiato.yaml";
        sha256 = "1wxws344d1m5svwc0gzbfxg5vjb16smpsdi28j25h7c4fz36kdwz";
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
