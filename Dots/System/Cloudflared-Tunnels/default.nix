{ pkgs, ... }:
{
  systemd.services = {
    copyparty-tunnel = {
      wantedBy = [ "multi-user.target" ]; # run when the system is up...
      after = [ "network-online.target" ]; # ...but after the network has been set up.

      description = "Start a Cloudflared tunnel to tunnel Copyparty";

      serviceConfig = {
        Type = "notify";

        ExecStart = ''${pkgs.cloudflared}/bin/cloudflared tunnel --origincert /home/formuna/.cloudflared/cert.pem run Copyparty'';
      };
    };
  };
}
