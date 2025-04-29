{ config, ... }: {
  # Terminal section
  programs.kitty.enable = true; # Installs Kitty. Theme is managed by Stylix
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = { sysman = "python3 /etc/nixos/Scripts/sysman.py"; };

    initExtra = ''
      # other config...
      export GOOGLE_AI_API_KEY=$(cat ${config.sops.secrets.geminiApiKey.path})
      export OPENAI_API_KEY=$(cat ${config.sops.secrets.chatGPTApiKey.path})
    '';
  };
}
