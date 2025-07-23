{ pkgs, nixvim, ... }: {
  environment.systemPackages = [
    (nixvim.legacyPackages."${pkgs.stdenv.hostPlatform.system}".makeNixvim {
      colorschemes.gruvbox.enable = true;
    })
  ];
}
