{ ... }:
{
  # Allow non-FOSS packages on my system.
  nixpkgs.config.allowUnfree = true;

  # Enable some of Nix's experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Nix-LD for binaries
  programs.nix-ld.enable = true;
}
