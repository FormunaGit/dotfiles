{ inputs, pkgs, ... }:
let
  hypr = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.hyprland = {
    enable = true;
    withUWSM = true; # Enable Universal wayland session manager
    package = hypr.hyprland; # Set the Hyprland package to the one from the flake
    portalPackage = hypr.xdg-desktop-portal-hyprland; # Same with the portal
  };
}
