{ pkgs, ... }:
{
  # Currently only 1 user
  users = {
    defaultUserShell = pkgs.fish; # Set Fish as the default shell
    users.formuna = {
      isNormalUser = true; # This user is a human
      description = "Formuna"; # The human readable name for the user
      extraGroups = [
        "networkmanager" # Control over NetworkManager
        "wheel" # Sudo privileges
        "adbusers" # Access to sudo-less ADB
        "video" # For display/graphics access
        "docker" # Sudo-less docker
        "scanner"
        "lp"
      ];
    };
  };
}
