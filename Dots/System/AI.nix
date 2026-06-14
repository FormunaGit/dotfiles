{ ... }:
{
  services.ollama = {
    enable = true;
    syncModels = true;
    openFirewall = true;
    loadModels = [
      "qwen2.5:1.5b"
    ];
  };

  services.hermes-agent = {
    enable = true;
    settings = {
      model = {
        default = "ollama/qwen2.5:1.5b";
        base_url = "http://localhost:11434";
      };
    };
    addToSystemPackages = true;
  };
}
