{ inputs, pkgs, ... }:
{
  imports = [
    inputs.mcp-servers-nix.homeManagerModules.default
  ];

  services.mcp-servers = {
    enable = true;

    # Define your servers declaratively
    settings.mcpServers = {
      nixos = {
        command = "nix";
        args = [
          "run"
          "github:utensils/mcp-nixos"
          "--"
        ];
      };

      open-websearch = {
        command = "${pkgs.nodejs}/bin/npx";
        args = [
          "-y"
          "@iflow-mcp/open-websearch@latest"
        ];
      };
    };
  };
}
