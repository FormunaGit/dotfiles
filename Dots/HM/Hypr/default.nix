{ pkgs, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = (builtins.readFile ./hyprland.conf); # TODO: Disable this soonTM
    plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
      hyprbars
    ];

    # TODO: Finish the Nix-ified config vvv
    #settings = {
    #  monitor = "HDMI-1, 1680x1050, 0x0, 1";
    #
    #  # My programs
    #  "$terminal" = "kitty"; # TODO: Replace this with Ghostty
    #  "$fileManager" = "kitty --hold fish -c 'superfile'"; # TODO: ^^^
    #  "$menu" = "rofi -show drun"; # TODO: Replace with widget system
    #
    #  # Autostarts
    #  exec-once = "swaync"; # TODO: Replace with widget system
    #  exec-once = "waybar"; # TODO: ^^^
    #  exec-once = "wl-paste --type text --watch cliphist store"; # TODO: Replace
    #  exec-once = "wl-paste --type image --watch cliphist store"; # TODO: ^^^
    #  exec-once = "";
    #};
  };
}
