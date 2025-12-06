{ pkgs, inputs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = (builtins.readFile ./hyprland.conf);

    plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
      hyprbars
    ];
  };
}
