{ inputs, ... }: {
  imports = [ 
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    nixpkgs.useGlobalPackages = true;

    # performance = {
    #   combinePlugins = {
    #     enable = true;
    #     standalonePlugins = [
    #       "hmts.nvim"
    #       "neorg"
    #       "nvim-treesitter"
    #     ];
    #   };
    #   byteCompileLua.enable = true;
    # };

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;
  };
}
