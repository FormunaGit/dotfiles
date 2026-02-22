{ inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
    ./settings.nix
    ./plugins.nix
    ./colors.nix
  ];

  programs.noctalia.enable = true;
}
