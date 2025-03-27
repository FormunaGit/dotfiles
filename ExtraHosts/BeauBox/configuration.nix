{ config, pkgs, lib, ... }:

let
  user = "formuna";
  password = (builtins.readFile config.sops.secrets.beauboxSecrets.userPassword.path);
  SSID = (builtins.readFile config.sops.secrets.beauboxSecrets.SSID.path);
  SSIDpassword = (builtins.readFile config.sops.secrets.beauboxSecrets.SSIDPass.path);
  interface = "wlan0";
  hostname = "beaubox";
in {
  # Sops-nix related stuff
  #imports = [ <sops-nix/modules/sops> ];
  sops.defaultSopsFile = ../../secrets.json;
  sops.age.keyFile = "/home/formuna/.config/sops/age/keys.txt";
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking = {
    hostName = hostname;
    wireless = {
      enable = true;
      networks."${SSID}".psk = SSIDpassword;
      interfaces = [ interface ];
    };
  };

  environment.systemPackages = with pkgs; [ neovim ];

  services.openssh.enable = true;

  users = {
    mutableUsers = false;
    users."${user}" = {
      isNormalUser = true;
      password = password;
      extraGroups = [ "wheel" ];
    };
  };

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "23.11";
}
