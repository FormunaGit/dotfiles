{
  programs.plasma = {
    enable = true;
    workspace = {
      clickItemTo = "select";
      cursor = {
        theme = "Bibata-Modern-Classic";
        size = 32;
      };
      iconTheme = "Papirus-Dark";
    };

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Q";
      command = "konsole";
    };

    panels = [{
      location = "top";
      widgets = [{
        name = "org.kde.plasma.kickoff";
        config = {
          General = {
            icon = "nix-snowflake-white";
            alphaSort = true;
          };
        };
      }];
    }];
  };
}
