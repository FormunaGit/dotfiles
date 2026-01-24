{ pkgs, inputs, ... }:
{
  home.stateVersion = "25.05"; # Version of Home Manager.

  imports = [
    inputs.textfox.homeManagerModules.default
    ../Dots/HM
    (import ../Dots/Shared/Theme.nix)
  ];

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
