{ inputs, pkgs, ... }: {
  imports = [ inputs.nixvim.homeModules.nixvim ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    #viAlias = true;
    #vimAlias = true;
    enable = true;
    nixpkgs.useGlobalPackages = true;
    defaultEditor = true;
    clipboard.providers.wl-copy.enable = true;
    colorschemes.gruvbox.enable = true;
    globals.mapleader = " ";
    imports = [ ./options.nix ];

    keymaps = [{
      action = "<cmd>Telescope live_grep<CR>";
      key = "<leader>g";
    }];

    luaLoader.enable = true;

    plugins = {
      # LSP
      lsp = {
        enable = true;
        servers = {
          # Nix
          nixd.enable = true;

          # TypeScript/JavaScript
          ts_ls.enable = true;

          # Rust
          rust_analyzer = {
            enable = true;
            installRustc = true;
	    installCargo = true;
          };

	  # Go
	  gopls.enable = true;
        };
      };

      # Auto-complete
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "luasnip"; }
          ];

          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" =
              "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })";
          };
        };
      };

      ### Config-less plugins ###
      lualine.enable = true; # Cool status bar
      dashboard.enable = true; # Start screen thing (TODO: Customize this)
      telescope.enable = true; # Fuzzy finder
      oil.enable = true; # Neat file explorer
      treesitter.enable = true; # Parsers and highlighting
      luasnip.enable = true; # Snippet engine
      web-devicons.enable = true; # Icons
      aider.enable = true; # Coding AI
    };
  };
}
