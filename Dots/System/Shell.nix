{ ... }:
let
  baseEza = "eza --icons=always --git";
in
{
  # Enable Fish shell
  programs.fish = {
    enable = true;
    # Use Zoxide for CD alternative
    shellInit = "zoxide init fish --cmd cd | source";
  };

  # Global shell aliases
  environment.shellAliases = {
    # NixOS/NH
    rebuild = "nh os switch ~/nixos --impure";
    update = "nh os switch ~/nixos --impure --update";

    # Eza as LS alternative
    ls = baseEza;
    la = baseEza + " -la";
    l = baseEza + " -laa";
  };

  # Enable Starship
  programs.starship.enable = true;
}
