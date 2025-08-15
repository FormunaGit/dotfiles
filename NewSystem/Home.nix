{ pkgs, inputs, ... }: {
  home.stateVersion = "25.05"; # Version of Home Manager.

  imports = [
    inputs.textfox.homeManagerModules.default
    inputs.ignis.homeManagerModules.default
  ];

  # Sops-nix config
  sops = {
    age.keyFile =
      "/home/formuna/.config/sops/age/keys.txt"; # DON'T SHARE THESE KEYS!!
    defaultSopsFile = ../secrets.json; # Secrets file, use `sops edit` to edit.
    defaultSymlinkPath = "/run/user/1000/secrets"; # Secrets path.
    defaultSecretsMountPoint = "/run/user/1000/secrets.d"; # Secrets path 2.

    secrets.openrouterApiKey.path =
      "/run/user/1000/secrets/openrouterApiKey"; # API key for OpenRouter
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
      export OPENROUTER_API_KEY=$(cat /run/user/1000/secrets/openrouterApiKey)
    '';
  };

  # ~/.config/nixpkgs/config.nix
  home.file.npkgsconfig = {
    target = ".config/nixpkgs/config.nix";
    text = ''
      { packageOverrides = pkgs: { nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") { inherit pkgs; }; }; }'';
  };

  # TUI theme for GNOME.
  textfox = {
    enable = true;
    profile = "sroktgkn.default";
  };

  # Hyprland!
  #wayland.windowManager.hyprland = {
  #  enable = true;
  #  systemd.enable =
  #    false; # Disable Hyprland systemd integration to work with UWSM
  #};
  services.hyprpolkitagent.enable = true;

  # Ignis
  programs.ignis = {
    enable = true;

    # Add Ignis to the Python environment (useful for LSP support)
    addToPythonEnv = true;

    # Put a config directory from your flake into ~/.config/ignis
    # NOTE: Home Manager will copy this directory to /nix/store
    # and create a symbolic link to the copy.
    configDir = ../Shell;

    # Enable dependencies required by certain services.
    # NOTE: This won't affect your NixOS system configuration.
    # For example, to use NetworkService, you must also enable
    # NetworkManager in your NixOS configuration:
    #   networking.networkmanager.enable = true;
    services = {
      bluetooth.enable = true;
      recorder.enable = true;
      audio.enable = true;
      network.enable = true;
    };

    # Enable Sass support
    sass = {
      enable = true;
      useDartSass = true;
    };

    # Extra packages available at runtime
    # These can be regular packages or Python packages
    # extraPackages = with pkgs; [
    #   hello
    #   python313Packages.jinja2
    #   python313Packages.materialyoucolor
    #   python313Packages.pillow
    # ];
  };

  home.sessionVariables.NIXOS_OZONE_WL =
    "1"; # Hint to Electron apps to use Wayland
}
