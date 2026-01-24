{ ... }:
{
  # SSH
  services.openssh = {
    enable = true;
    ports = [ 2222 ]; # Put SSH on a different port
    openFirewall = true; # Obviously.
    settings = {
      PasswordAuthentication = false; # Disable password auth and prefer keys
      KbdInteractiveAuthentication = false; # ^^^
      PermitRootLogin = "no"; # Do not allow access to the root user
      AllowUsers = [ "formuna" ]; # Only allow connecting to my account
    };
  };

  # Temp-ban anyone who keeps trying to connect without a key
  services.fail2ban.enable = true;

  # SSH tarpit
  services.endlessh = {
    enable = true;
    port = 22; # Uses the standard port for rookie bots
    openFirewall = true; # Obviously.
  };

  # Docker
  virtualisation.docker.enable = true;
}
