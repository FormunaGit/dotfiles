{ pkgs, inputs, ... }: {
  imports = [ inputs.ags.homeManagerModules.default ]; # AGS Module.

  home.stateVersion = "24.11"; # Version of Home Manager.

  # Sops-nix config
  sops = {
    age.keyFile =
      "/home/formuna/.config/sops/age/keys.txt"; # DON'T SHARE THESE KEYS!!
    defaultSopsFile = ../secrets.json; # Secrets file, use `sops edit` to edit.
    defaultSymlinkPath = "/run/user/1000/secrets"; # Secrets path.
    defaultSecretsMountPoint = "/run/user/1000/secrets.d"; # No idea.
  };

  # Enable HM Hyprland Module
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs.hyprlandPlugins; [
      hypr-dynamic-cursors # Cool cursor animations
      hyprspace # Workspace overview plugin
    ];
    extraConfig = toString (builtins.readFile ../Dotfiles/hypr/hyprland.conf);
    package = null;
    portalPackage = null; # Fix for Roblox Studio
  };

  # Cliphist for clipboard
  services.cliphist = {
    enable = true;
    allowImages = true;
  };

  # Player Control Daemon
  services.playerctld.enable = true;

  # Trayscale, GUI for Tailscale
  services.trayscale = {
    enable = true;
    hideWindow = true;
  };

  # OBS!
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-3d-effect
      obs-vkcapture
      wlrobs
    ];
  };

  # Create custom Emacs.desktop file that loads in the config in an imperative way
  xdg.desktopEntries = {
    refreshedEmacs = {
      name = "Refreshed Emacs";
      genericName = "Code Editor";
      exec = "emacs -q -l /etc/nixos/Dotfiles/emacs/init.el";
      terminal = false;
      categories = [ "Development" ];
    };
  };

}
