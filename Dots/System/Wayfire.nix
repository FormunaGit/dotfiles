{ ... }:
{
  programs.wayfire = {
    enable = true;
  };

  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-gtk
  #   ];
  #   config = {
  #     common = {
  #       default = [ "gtk" ];
  #       "org.freedesktop.impl.portal.Screencast" = [ "wlr" ];
  #       "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
  #     };
  #   };
  # };

  # environment.sessionVariables = {
  #   XDG_CURRENT_DESKTOP = "wayfire";
  # };
}
