# For syncronizing things like my music.
{ ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;

    settings = {
      folders = {
        "Music" = {
          path = "/home/formuna/Data/Music";
        };
      };
    };
  };
}
