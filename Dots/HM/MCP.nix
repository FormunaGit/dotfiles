{ inputs, ... }:
{
  imports = [
    inputs.nix-mcp-servers.homeManagerModules.default
  ];

  services.mcp-servers = {
    enable = true;

    # Define your servers declaratively
    servers = {
      nixos = {
        command = "nix";
        args = [
          "run"
          "github:utensils/mcp-nixos"
          "--"
        ];
      };

      open-websearch = {
        args = [
          "-y"
          "@iflow-mcp/open-websearch@latest"
        ];
      };
    };
  };
}
