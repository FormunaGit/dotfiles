{ inputs, ... }:
{
  imports = [ inputs.ignis.homeManagerModules.default ];

  programs.ignis = {
    enable = true;

    # Useful for LSP.
    addToPythonEnv = true;

    # Enable dependencies required by certain services.
    services = {
      bluetooth.enable = true;
      recorder.enable = true;
      audio.enable = true;
      network.enable = true;
    };

    # Enable SASS support
    sass = {
      enable = true;
      useDartSass = true;
    };
  };
}
