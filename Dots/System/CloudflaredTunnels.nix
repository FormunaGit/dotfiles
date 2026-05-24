{ pkgs, ... }:
let
  cl-tunnel = "${pkgs.cloudflared}/bin/cloudflared tunnel --origincert /home/formuna/.cloudflared/cert.pem run ";
in
{
  systemd.services = {
    copyparty-tunnel = {
      wantedBy = [ "multi-user.target" ];
      wants = [ "network-online.target" ];
      after = [ "network-online.target" ];

      description = "Start a Cloudflared tunnel to tunnel Copyparty";

      serviceConfig = {
        Type = "notify";

        ExecStart = cl-tunnel + "Copyparty";
      };
    };

    n8n-tunnel = {
      wantedBy = [ "multi-user.target" ];
      wants = [ "network-online.target" ];
      after = [ "network-online.target" ];

      description = "Start a Cloudflared tunnel to tunnel n8n";

      serviceConfig = {
        Type = "notify";

        ExecStart = cl-tunnel + "n8n";
      };
    };
  };
}
