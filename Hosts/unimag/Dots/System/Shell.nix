{ ... }:
{
  # Enable Fish shell
  programs.fish = {
    enable = true;
    shellInit = "zoxide init fish | source";
  };

  # Enable Starship
  programs.starship.enable = true;
}
