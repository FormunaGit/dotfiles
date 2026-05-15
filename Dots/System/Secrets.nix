{ inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../../secrets.json;
    defaultSopsFormat = "json";

    age.keyFile = "/home/formuna/.config/sops/age/keys.txt";
  };
}
