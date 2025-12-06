{ inputs, lib, ... }:
{
  imports = [ inputs.kickstart-nixvim.homeManagerModules.default ];

  programs.nixvim = {
    enable = true;

    colorschemes.tokyonight.enable = lib.mkForce false; # Force-disable Tokyo Night...
    colorschemes.gruvbox-material.enable = true; # ...and enable Gruvbox (Material)

    plugins = {
      barbar.enable = true; # Tabline plugin
      lualine.enable = true; # Statusline plugin
      web-devicons.enable = lib.mkForce true; # Icons
      oil.enable = true; # Cool file explorer
      codecompanion.enable = true; # AI coding tool
    };
  };
}
