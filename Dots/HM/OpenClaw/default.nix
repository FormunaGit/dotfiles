{ inputs, osConfig, ... }:
{
  imports = [ inputs.nix-openclaw.homeManagerModules.openclaw ];

  programs.openclaw = {
    enable = true;
    documents = ./Documents;

    config.gateway = {
      mode = "local";
      auth.token = (builtins.readFile osConfig.sops.secrets.ocGatewayToken.path);
    };
  };
}
