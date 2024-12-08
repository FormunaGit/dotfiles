{ config, pkgs, ... }:

# Define Waybar configuration (Part 1/2)
let
  # Import the Waybar configuration
  waybarConfig = import ./dotfiles/waybar/config.nix;
in

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

  # Import Waybar configuration from waybarConfig variable (Part 2/2)
  programs.waybar = waybarConfig.programs.waybar;

  # Enable the default Home Manager configuration.
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {  };

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
