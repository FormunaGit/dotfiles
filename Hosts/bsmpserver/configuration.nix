{
  pkgs,
  ...
}:
{
  imports = [
    ./Modules/hardware-configuration.nix # System's preconfigured hardware module.
  ];

  environment.systemPackages = with pkgs; [
    zellij # Terminal multiplexer
    btop # Cool *top program
  ];

  programs.nh = {
    enable = true; # Cool Nix CLI thing
    clean.enable = true; # Automatically clean nixstore every week
  };

  networking = {
    hostName = "bsmpserver"; # System hostname
    networkmanager.enable = true; # Enable Wi-Fi

    firewall = {
      # Currently empty.
      allowedUDPPorts = [ ];
      allowedTCPPorts = [ ];
    };
  };

  # The systemd DNS resolver
  services.resolved.enable = true;

  # Docker
  virtualisation.docker.enable = true;

  # Tailscale
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "both";
  };

  # SSH
  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    openFirewall = true;
  };

  users = {
    defaultUserShell = pkgs.fish; # Use Fish as the default user shell
    users.invilutzu = {
      # Friend's account
      isNormalUser = true; # Sets a bunch of other things for convenience
      description = "Invilutzu";
      extraGroups = [
        "networkmanager" # NetworkManager access
        "wheel" # Sudo privileges
        "video" # Kinda forgot what this does
        "docker" # Docker
      ];
    };
  };
}
