{ ... }: {
  services.wayvnc = {
    enable = true;
    settings = {
      address = "127.0.0.1";
      port = 5901;
      xkb_model = "evdev";
      xkb_layout = "us";
    };
  };
}
