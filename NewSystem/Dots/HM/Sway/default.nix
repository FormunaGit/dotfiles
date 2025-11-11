{ ... }: 
{
  wayland.windowManager.sway = {
    enable = true;
    extraConfig = (builtins.readFile ./sway.cfg);
  };
}
