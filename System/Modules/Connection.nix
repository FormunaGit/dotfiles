# ####################
##  Connection.nix  ##
######################
# This file is for   #
# programs that let  #
# the system communi #
# -cate to other dev #
# -ices such as rout #
# -ers.              #
######################
{ config, lib, ... }: {
  # Wi-Fi
  networking.networkmanager = {
    enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # ADB
  programs.adb.enable = true;

  # Printer & Scanner
  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
  hardware.sane.enable = true;
}
