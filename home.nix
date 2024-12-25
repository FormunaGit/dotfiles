{ config, pkgs, ... }:
######################################################
### IMPORTANT THINGS TO KNOW WHEN EDITING DOTFILES ###
######################################################
# Try to add stuff in a declarative form. Don't just #
# add random stuff to the system config file. These  #
# dotfiles are made to work for a single-user system #
# (not counting Nix's build users.) Instead, try to  #
# install apps here, in the user-specific HM config  #
# to not clutter up the system, and to not require   #
# root access to install Spotify, or some other gen- #
# eric app that doesn't need root access.            #
######## INSTALL THINGS IN A DECLARATIVE WAY! ########
######## USE MYNIXOS.COM TO FIND HM OPTIONS! #########
######################################################


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

  # Enable (and configure) ZSH]
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      sysman = "~/.config/home-manager/scripts/sysman.py";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./dotfiles/p10k;
        file = "p10k.zsh";
      }
    ];
  };

  # Enable Kitty
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
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

  # Import Quickshell
  imports = [ (builtins.getFlake "github:quickshell-mirror/quickshell").homeManagerModules.default ];

  #######################
  ### SERVICE SECTION ###
  #######################
  # This section is for #
  # decrlaratively inst #
  # aling services.    #
  #######################
  services = {
    cliphist = { # Wayland clipboard manager
      enable = true;
      allowImages = true;
    };
    playerctld.enable = true; # Media player daemon
    mako = { # Notification daemon
      enable = true;
      extraConfig = toString (builtins.readFile ./dotfiles/mako/config);
    };
    trayscale = { # Unofficial GUI for Tailscale
      enable = true;
      hideWindow = true;
    };
  };

  #######################
  ### PROGRAM SECTION ###
  #######################
  # This section is for #
  # decrlaratively inst #
  # aling programs.    #
  #######################
  programs = {
    fastfetch.enable = true; # Faster remake of neofetch
    wofi.enable = true; # Neat launcher
    neovim = { # TUI editor, fork of Vim
      enable = true;
      defaultEditor = true;
      withPython3 = true;
    };
    git.enable = true; # Land of the doomed
    lazygit.enable = true; # Git TUI
    

    # VSCod(ium)
    vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc # Catppuccin theme
        catppuccin.catppuccin-vsc-icons # Catppuccin icons
        jnoortheen.nix-ide # Nix language support (better than bbenoist.nix)
        ms-python.python # Python language support
        jeff-hykin.better-nix-syntax # Better Nix syntax
      ];
    };
  };


  # Enable the default Home Manager configuration.
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Add some packages here that can't be installed declaratively. If it also has support for dotfiles, use home.file.
  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {};

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
