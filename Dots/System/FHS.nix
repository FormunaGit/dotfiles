{ inputs, ... }:
{
  # I probably will never contribute to nixpkgs so...
  imports = [ inputs.nixos-fhs-compat.nixosModules.combined ];
  environment.fhs.enable = true;
  environment.fhs.linkLibs = true;
  environment.lsb.enable = true;
  environment.lsb.support32Bit = true;
}
