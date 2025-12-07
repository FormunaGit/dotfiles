{ ... }:
let
  scripts = "/home/formuna/Data/ServerSettings/PrivateScripts";
in
{
  systemd.services.copyparty-tunnel = {
    wantedBy = [ "multi-user.target" ]; # run when the system is up...
    after = [ "network.target" ]; # ...but after the network has been set up.

    description = "Start a Cloudflared tunnel to tunnel Copyparty";

    serviceConfig = {
      Type = "notify";

      ExecStart = ''${scripts}/CopypartyTunnel.sh'';
    };
  };
}
