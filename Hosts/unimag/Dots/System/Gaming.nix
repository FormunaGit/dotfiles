{ ... }:
{
  # Steam
  programs.steam = {
    enable = true;
    protontricks.enable = true; # Install the Valve-flavored Winetricks
  };
}
