######################################################################
# ███████ ███    ███  █████   ██████ ███████    ███    ██ ██ ██   ██ #
# ██      ████  ████ ██   ██ ██      ██         ████   ██ ██  ██ ██  #
# █████   ██ ████ ██ ███████ ██      ███████    ██ ██  ██ ██   ███   #
# ██      ██  ██  ██ ██   ██ ██           ██    ██  ██ ██ ██  ██ ██  #
# ███████ ██      ██ ██   ██  ██████ ███████ ██ ██   ████ ██ ██   ██ #
######################################################################
# The Nix file for all my Emacs-related shenanigans. Should be impor #
# -ted into home.nix.                                                #
######################################################################
{ pkgs, ... }: {
 services.emacs = { # Enable the server
   enable = true;
   package = pkgs.emacs30-gtk3; # I like GTK.
 };

 environment.systemPackages = [
   (pkgs.emacsWithPackagesFromUsePackage {
     package = pkgs.emacs30-gtk3;
     config = ../../Dotfiles/emacs/init.el
   })
 ];
};