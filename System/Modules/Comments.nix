# Don't import this (not even a) module.
# ##########################
##      Comments.nix      ##
############################
# Comments that are in     #
# other Nix files that     #
# may be useful some day.  #
############################
{
  # In pipewire audio section /*
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;

  # use the example session manager (no others are packaged yet so this is enabled by default,
  # no need to redefine it in your config for now)
  #media-session.enable = true;
  # */

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

}
