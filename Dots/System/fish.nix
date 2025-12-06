{ ... }:
{
  programs.fish = {
    shellInit = "zoxide init fish | source";
  };
}
