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
      neo-tree.enable = true; # Sidebar file explorer
      cord.enable = true; # Discord integration
    };

    lsp.servers = {
      pyright.enable = true; # PyRight for Python
      tombi.enable = true; # Tombi for TOML
      gleam.enable = true; # Gleam
    };
  };
}
