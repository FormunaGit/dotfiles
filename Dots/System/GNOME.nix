{ pkgs, ... }:
{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome.games.enable = false;

  environment.systemPackages = with pkgs.gnomeExtensions; [
    dash-to-dock
    just-perfection
    arc-menu
    another-window-session-manager
    appearance-keeper
    appindicator
    athantimes
    blur-my-shell
    boost-volume
    burn-my-windows
    clipboard-history
    cmud
    compiz-alike-magic-lamp-effect
    compiz-windows-effect
    desktop-cube
  ];
}
