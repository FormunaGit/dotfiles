{
  # Enable Waybar
  programs.waybar = {
    enable = true;
    settings = {
      top-bar = {
        layer = "bottom";
        modules-left = [ "custom/ilovemypc" "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "tray" ];
        position = "top";
        tray = {
          icon-size = 20;
          spacing = 10;
        };

        "custom/ilovemypc" = {
          format = " +  = 󰋑 ";
          tooltip-format = "I love NixOS. I love Hyprland. I love Firefox. I love Waybar.";
        };
      };

      bottom-bar = {
        layer = "bottom";
        modules-left = [ "battery" "cpu" "backlight" "memory" "pulseaudio" ];
        modules-center = [ "clock" ];
        modules-right = [ "custom/clearnotifs" ];
        position = "bottom";

        "custom/clearnotifs" = { # Clears all Mako notifications
          format = "Clear Notifications";
          on-click = "makoctl dismiss -a";
        };

        battery = {
          format = "{capacity}% {icon}";
          format-icons = [ " " " " " " " " " " ];
        };

        cpu = {
          interval = 1;
          format = "{}%  ";
          max-length = 10;
        };

        memory = {
          interval = 1;
          format = "{}%  ";
          max-length = 10;
        };

      pulseaudio = {
        format = "{volume}% {icon}";
        format-bluetooth = "{volume}% {icon}";
        format-muted = " ";
        format-icons = {
          headphone = " ";
          hands-free = "?";
          headset = " ";
          phone = " ";
          phone-muted = " ";
          portable = " ";
          car = " ";
          default = [ " " " " ];
        };
        scroll-step = 1;
        on-click = "pavucontrol";
        ignored-sinks = [ "Easy Effects Sink" ];
      };
      };
    };

    style = builtins.readFile ./style.css;
  };
}
