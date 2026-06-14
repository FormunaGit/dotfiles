{ config, pkgs, ... }: {
  # make sure dconf is installed
  home.packages = [ pkgs.dconf ];

  # symlink dconf.ini to ~/.config
  xdg.configFile."dconf/dconf.ini".source = ./dconf.ini;

  # load config
  home.activation = {
    loadDconf = config.lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ -f "${config.xdg.configDir}/dconf/dconf.ini" ]; then
        $DRY_RUN_CMD ${pkgs.dconf}/bin/dconf load / < ${config.xdg.configDir}/dconf/dconf.ini
      fi
    '';
  };
}
