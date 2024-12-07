{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "formuna";
  home.homeDirectory = "/home/formuna";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Enable Kitty
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "JetBrains Mono NL";
    };
  };

  # Enable Mako
  services.mako = {
    enable = true;
    extraConfig = toString (builtins.readFile ./dotfiles/mako/config);
  };

  # Enable Hyprland (and get it actually running)
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hyprbars
    ];
    extraConfig = toString (builtins.readFile ./dotfiles/hypr/hyprland.conf);
  };

  # Enable Waybar
  programs.waybar = {
    enable = true;
    settings = {
      top-bar = {
        layer = "top";
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "tray" ];
        position = "top";

        tray = {
          icon-size = 20;
          spacing = 10;
        };
      };
      bottom-bar = {
        layer = "bottom";
        modules-left = [ "battery" ];
        modules-center = [ "clock" ];
        modules-right = [ "cpu" "backlight" "memory" "pulseaudio" ];
        position = "bottom";

        battery = {
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
        };

        cpu = {
          interval = 10;
          format = "{}%  ";
          max-length = 10;
        };

      pulseaudio = {
        format = "{volume}% {icon}";
        format-bluetooth = "{volume}% {icon}";
        format-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          phone-muted = " ";
          portable = " ";
          car = " ";
          default = [ "" "" ];
        };
        scroll-step = 1;
        on-click = "pavucontrol";
        ignored-sinks = [ "Easy Effects Sink" ];
      };
      };
    };

    style = builtins.readFile ./dotfiles/waybar/style.css;
  };

  # Enable the default Home Manager configuration.
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/formuna/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
