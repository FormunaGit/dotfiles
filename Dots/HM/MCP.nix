{ pkgs, inputs, ... }:
let
  # Generate the config as a Nix attribute set first
  mcpConfig = inputs.mcp-servers-nix.lib.mkConfig pkgs {
    programs = {
      filesystem.enable = true;
      fetch.enable = true;
    };
    settings.mcpServers.open-websearch = {
      command = "${pkgs.nodejs}/bin/npx";
      args = [
        "-y"
        "@iflow-mcp/open-websearch@latest"
      ];
    };
  };
in
{
  # Use pkgs.writeText to create the final file,
  # which bypasses the "refer to store path" restriction on direct .text assignment
  home.file.".gemini/settings.json".source = pkgs.writeText "gemini-settings.json" (
    builtins.toJSON {
      selectedAuthType = "gemini-api-key";
      # We take the derivation's output and extract just the inner servers
      mcpServers = (builtins.fromJSON (builtins.readFile mcpConfig)).mcpServers;
    }
  );
}
