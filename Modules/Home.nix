{ pkgs, inputs, ... }:
{
  home.stateVersion = "25.05"; # Version of Home Manager.

  imports = [
    inputs.textfox.homeManagerModules.default
    ../Dots/HM
    (import ../Dots/Shared/Theme.nix)
  ];

  # Sops-nix config
  sops = {
    age.keyFile = "/home/formuna/.config/sops/age/keys.txt"; # DON'T SHARE THESE KEYS!!
    defaultSopsFile = ../secrets.json; # Secrets file, use `sops edit` to edit.
    defaultSymlinkPath = "/run/user/1000/secrets"; # Secrets path.
    defaultSecretsMountPoint = "/run/user/1000/secrets.d"; # Secrets path 2.
  };

  # OBS!
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-3d-effect
      wlrobs
    ];
  };

  # GTK config to fix improper icon theme.
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  # ~/.config/nixpkgs/config.nix
  home.file.npkgsconfig = {
    target = ".config/nixpkgs/config.nix";
    text = ''{ packageOverrides = pkgs: { nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") { inherit pkgs; }; }; }'';
  };

  # TUI theme for Firefox.
  textfox = {
    enable = true;
    profile = "sroktgkn.default";
  };

  services.hyprpolkitagent.enable = true;

  home.sessionVariables.NIXOS_OZONE_WL = "1"; # Tell some apps to Wayland-ify
}
