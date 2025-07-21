{ pkgs, inputs, ... }: {
  home.stateVersion = "24.11"; # Version of Home Manager.

  imports = [ inputs.textfox.homeManagerModules.default ];

  # Sops-nix config
  sops = {
    age.keyFile =
      "/home/formuna/.config/sops/age/keys.txt"; # DON'T SHARE THESE KEYS!!
    defaultSopsFile = ../secrets.json; # Secrets file, use `sops edit` to edit.
    defaultSymlinkPath = "/run/user/1000/secrets"; # Secrets path.
    defaultSecretsMountPoint = "/run/user/1000/secrets.d"; # No idea.

    secrets = {
      geminiApiKey.path = "/run/user/1000/secrets/geminiApiKey";
      openrouterApiKey.path = "/run/user/1000/secrets/openrouterApiKey";
    };
  };

  # OBS!
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [ obs-3d-effect wlrobs ];
  };

  # GTK config to fix improper icon theme.
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  # Fish config for secrets
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      export GOOGLE_AI_API_KEY=$(cat /run/user/1000/secrets/geminiApiKey)
      export OPENROUTER_API_KEY=$(cat /run/user/1000/secrets/openrouterApiKey)
    '';
  };

  # ~/.config/nixpkgs/config.nix
  home.file.npkgsconfig = {
    target = ".config/nixpkgs/config.nix";
    text = ''
      { packageOverrides = pkgs: { nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") { inherit pkgs; }; }; }'';
  };

  textfox = {
    enable = true;
    profile = "sroktgkn.default";
  };
}
