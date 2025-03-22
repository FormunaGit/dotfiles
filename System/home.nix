{ pkgs, inputs, config, ... }:
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
# eric app that doesn't need root access. Thanks >:3 #
######## INSTALL THINGS IN A DECLARATIVE WAY! ########
######## USE MYNIXOS.COM TO FIND HM OPTIONS! #########
######################################################

let
  # Import the Waybar configuration
  waybarConfig = import ../Dotfiles/waybar/config.nix;
  #plasmaConfig = import ../SystemModules/plasma.nix;
in {
  imports = [
    inputs.ags.homeManagerModules.default # AGS module
    (import ./Modules/Development-Home.nix {
      inherit config;
    }) # Dev tools module, for HM
    (import ./Modules/Emacs.nix { inherit pkgs; }) # Emacs module
  ];
  # Home Manager needs a bit of information about yon and the paths it should
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

  # Sops(-nix)
  sops = {
    age.keyFile = "/home/formuna/.config/sops/age/keys.txt";

    defaultSopsFile = ../secrets.json;
    defaultSymlinkPath = "/run/user/1000/secrets";
    defaultSecretsMountPoint = "/run/user/1000/secrets.d";

    secrets = {
      geminiApiKey.path = "${config.sops.defaultSymlinkPath}/geminiApiKey";
      chatGPTApiKey.path = "${config.sops.defaultSymlinkPath}/chatGPTApiKey";
    };
  };

  # Enable Hyprland (and get it actually running)
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [ ];
    extraConfig = toString (builtins.readFile ../Dotfiles/hypr/hyprland.conf);
  };

  # Import Waybar configuration from waybarConfig variable (Part 2/2)
  programs.waybar = waybarConfig.programs.waybar;

  # Import Plasma configuration from plasmaConfig variable (Part 2/2)
  #programs.plasma = plasmaConfig.programs.plasma;

  #######################
  ### SERVICE SECTION ###
  #######################
  # This section is for #
  # decrlaratively inst #
  # alling services.    #
  #######################
  services = {
    cliphist = { # Wayland clipboard manager
      enable = true;
      allowImages = true;
    };
    playerctld.enable = true; # Media player daemon
    mako = { # Notification daemon
      enable = true;
      extraConfig = toString (builtins.readFile ../Dotfiles/mako/config);
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
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "atomicBit";
    };

    fastfetch.enable = true; # Faster remake of neofetch
    wofi.enable = true; # Neat launcher
    neovim = { # TUI editor, fork of Vim
      enable = true;
      defaultEditor = true;
      withPython3 = true;
    };

    ags = {
      enable = true;
      configDir = ../Shell;
      # additional packages to add to gjs's runtime
      extraPackages = [
        inputs.ags.packages.${pkgs.system}.astal3
        inputs.ags.packages.${pkgs.system}.apps
        inputs.ags.packages.${pkgs.system}.battery
        inputs.ags.packages.${pkgs.system}.network
        inputs.ags.packages.${pkgs.system}.hyprland
        inputs.ags.packages.${pkgs.system}.mpris
        inputs.ags.packages.${pkgs.system}.wireplumber
        inputs.ags.packages.${pkgs.system}.tray
        inputs.ags.packages.${pkgs.system}.notifd
      ];
    };

    # OBS + Plugins
    obs-studio = {
      enable = true;
      #plugins = with pkgs.obs-studio-plugins; [ obs-3d-effect obs-vkcapture wlrobs ];
    };

    # MangoHud
    mangohud.enable = true;

    # emacs = {
    #   enable = true;
    #   package = pkgs.emacs30-gtk3;
    #   #extraConfig = (builtins.readFile ../Dotfiles/emacs/init.el); 
    # };
  };

  # Enable the default Home Manager configuration.
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [ ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".emacs.d/init.el" = {
      text = (builtins.readFile ../Dotfiles/emacs/init.el);
      executable = false;
    };
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
  home.sessionVariables = { };

  # Enable custom .desktop files
  xdg.desktopEntries = {
    refreshedEmacs = {
      name = "Refreshed Emacs";
      genericName = "Code Editor";
      exec = "emacs -q -l /etc/nixos/Dotfiles/emacs/init.el";
      terminal = false;
      categories = [ "Development" ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
