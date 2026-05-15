{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./Modules/hardware-configuration.nix # System's preconfigured hardware module.
    (import ./Modules/Packages.nix { inherit pkgs inputs; }) # System Packages.
    (import ./Dots/System) # Custom module for styling and configuring my apps.
  ];

  # Polkit.
  security.polkit.enable = true;

  # Flatpak!
  services.flatpak.enable = true;

  system.stateVersion = "25.05"; # Don't change this value I guess.
}
