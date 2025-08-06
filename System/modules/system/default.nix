{ pkgs, inputs, ... }:

{
  imports = [
    # (import ./Modules/minecraft/default.nix {
    #   inherit pkgs inputs;
    # }) # Semi-declarative Minecraft server configuration
  ];

  environment.systemPackages = [
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
  ];
}
