{ pkgs, ... }:
{
  environment.systemPackages = with pkgs.libsForQt5; [
    qtstyleplugin-kvantum
    qt5ct
  ];

  qt5 = {
    enable = true;
    platformTheme = "qt5ct";
    style = {
      package = pkgs.utterly-nord-plasma;
      name = "Utterly Nord Plasma";
    };
  };

  environment.variables.QT_QPA_PLATFORMTHEME = "qt5ct";
}
