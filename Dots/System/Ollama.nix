{ ... }:
{
  services.ollama = {
    enable = true;
    syncModels = true;
    openFirewall = true;
    loadModels = [
      "qwen3.5:0.8b"
    ];
    host = "0.0.0.0";
  };
}
