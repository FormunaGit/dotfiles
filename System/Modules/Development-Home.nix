{ config, ... }: {
  # Gooey section
  #programs.zed-editor = { # The zeditor.
  #  enable = true;
  #  extensions =
  #    [ "nix" "catppuccin" "scss" "discord-presence" "toml" "wakatime" ];
  #  userSettings = {
  #    languages = {
  #      Nix = {
  #        language_servers = [ "nil" "!nixd" ];
  #        formatter = { external = { command = "nixfmt"; }; };
  #      };
  #    };
  ##    assistant = {
  #      enabled = true;
  #      version = "2";
  #      default_model = {
  #        provider = "openai";
  #        model = "4o-mini";
  #      };
  #    };
  #    theme = {
  #      mode = "system";
  #      dark = "Catppuccin Mocha";
  #      light = "Catppuccin Mocha";
  #    };
  #  };
  #};

  # Terminal section
  programs.kitty.enable = true; # Installs Kitty. Theme is managed by Stylix
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = { sysman = "python3 /etc/nixos/Scripts/sysman.py"; };

    initExtra = ''
      # other config...
      export TESTFORMUNA=$(cat ${config.sops.secrets.someKeyToNeverShare.path})
      export GOOGLE_AI_API_KEY=$(cat ${config.sops.secrets.geminiApiKey.path})
      export OPENAI_API_KEY=$(cat ${config.sops.secrets.chatGPTApiKey.path})
    '';

    plugins = [
      #{
      #  name = "powerlevel10k";
      #  src = pkgs.zsh-powerlevel10k;
      #  file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      #}
      #{
      #  name = "powerlevel10k-config";
      #  src = ../Dotfiles/p10k;
      #  file = "p10k.zsh";
      #}
    ];
  };
}
