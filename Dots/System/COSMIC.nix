{ ... }:
{
  services.desktopManager.cosmic.enable = true; # Enable COSMIC,
  services.displayManager.cosmic-greeter.enable = true; # and its greeter.

  services.system76-scheduler.enable = true; # Apparently good for COSMIC?

  environment.sessionVariables = {
    COSMIC_DATA_CONTROL_ENABLED = "1"; # Helps with screen-sharing ig
  };
}
