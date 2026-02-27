{
  pkgs,
  inputs,
  ...
}:
let
  hyprbarsLoad = "hyprctl plugin load ${
    inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
  }/lib/libhyprbars.so";
in
{
  imports = [ inputs.hyprland.homeManagerModules.default ];

  home.file.".config/hypr/loadplugins.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      ${hyprbarsLoad}'';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = (builtins.readFile ./hyprland.conf);
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [
      hyprbars
    ];

    #settings = {
    #  monitor = "HDMI-1, 1680x1050, 0x0, 1";
    #
    #  # My programs
    #  "$terminal" = "kitty"; # TODO: Replace this with Ghostty
    #  "$fileManager" = "kitty --hold fish -c 'superfile'"; # TODO: ^^^
    #  "$menu" = "rofi -show drun"; # TODO: Replace with widget system
    #
    #  # Autostarts
    #  exec-once = [
    #    # Background services
    #    "swaync" # TODO: Replace with Ignis
    #    "waybar" # TODO: ^^^^^^^^^^^^^^^^^^
    #    "wl-paste --type text --watch cliphist store" # Clipboard daemon
    #    "wl-paste --type image --watch cliphist store" # ^^^^^^^^^^^^^^^
    #    "awww-daemon" # Wallpaper daemon
    #
    #    # User applications
    #    "[workspace 1 silent] legcord" # Open Discord in workspace 1
    #    "[workspace 2 silent] firefox" # Open Firefox in workspace 2
    #  ];
    #};
  };
}
