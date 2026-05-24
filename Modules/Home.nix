{
  pkgs,
  inputs,
  config,
  ...
}:
{
  home.stateVersion = "25.05"; # Version of Home Manager.

  imports = [
    inputs.textfox.homeManagerModules.default
    ../Dots/HM
  ];

  # Setup XDG
  xdg.enable = true;

  # OBS!
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-3d-effect
      obs-pipewire-audio-capture
      waveform
      obs-tuna
      obs-retro-effects
      droidcam-obs
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

  # TUI theme for Firefox.
  textfox = {
    enable = true;
    profiles = [ "sroktgkn.default" ];
  };

  # Silence NixOS firefox error
  programs.firefox.configPath = ".mozilla/firefox";

  home.sessionVariables.NIXOS_OZONE_WL = "1"; # Tell some apps to Wayland-ify
}
