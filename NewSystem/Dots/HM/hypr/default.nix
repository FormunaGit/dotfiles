{ pkgs, inputs, ... }: let
  hypr = inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system};
in {
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with hypr; [
      hyprbars
      hyprtrails
    ];
  };
}
