{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [ inputs.kickstart-nixvim.homeManagerModules.default ];

  programs.nixvim = {
    enable = true;

    colorschemes.tokyonight.enable = lib.mkForce false; # Force-disable Tokyo Night...
    colorschemes.base16 = {
      enable = true;
      colorscheme = config.currentTheme.name_nvim;
    };
    #colorschemes.gruvbox-material.enable = true; # ...and enable Gruvbox (Material)

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
      ts_ls.enable = true; # TypeScript / JavaScript
      eslint.enable = true; # JS/TS linter
      luau_lsp.enable = true; # Luau LSP
    };
  };
}
