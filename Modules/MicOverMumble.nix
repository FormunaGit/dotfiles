# This file is for using my phone's mic as a PC mic
# using a nix-ified version of mic_over_mumble
# available here: https://discourse.nixos.org/t/using-a-phone-as-a-microphone/57172
{ ... }: {
  services.pipewire.extraConfig.pipewire."97-null-sink" = {
    "context.objects" = [
      {
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "Null-Sink";
          "node.description" = "Null Sink";
          "media.class" = "Audio/Sink";
          "audio.position" = "FL,FR";
        };
      }
      {
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "Null-Source";
          "node.description" = "Null Source";
          "media.class" = "Audio/Source";
          "audio.position" = "FL,FR";
        };
      }
    ];
  };
  services.pipewire.extraConfig.pipewire."98-virtual-mic" = {
    "context.modules" = [{
      name = "libpipewire-module-loopback";
      args = {
        "audio.position" = "FL,FR";
        "node.description" = "Mumble as Microphone";
        "capture.props" = {
          # Mumble's output node name.
          "node.target" = "Mumble";
          "node.passive" = true;
        };
        "playback.props" = {
          "node.name" = "Virtual-Mumble-Microphone";
          "media.class" = "Audio/Source";
        };
      };
    }];
  };
}
