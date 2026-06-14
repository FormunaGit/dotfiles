{ pkgs, ... }:
let
  college-font = pkgs.fetchzip {
    url = "https://dl.dafont.com/dl/?f=college";
    extension = "zip";
    hash = "sha256-1VQUFR6CAhTtL/J7SMOlBbNQ1Eh9gVCYgz08r3dw91M=";
    stripRoot = false;
  };
  mario-font = pkgs.stdenv.mkDerivation {
    name = "mario-font";
    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/yell0wsuit/MARIOFont/main/MARIO_Font_v3_Solid.otf";
      hash = "sha256-pvP6Nr//xeJroufTZE2YpDxQibsOUb1ODuHkE/sVDfI=";
    };
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/share/fonts/opentype
      cp $src $out/share/fonts/opentype/MARIO_Font_v3_Solid.otf
    '';
  };
  finger-paint-font = pkgs.stdenv.mkDerivation {
    name = "finger-paint-font";
    src = pkgs.fetchurl {
      url = "https://github.com/google/fonts/raw/main/ofl/fingerpaint/FingerPaint-Regular.ttf";
      hash = "sha256-/OAArgKLCcpTlJFyqDgoLGeHluFULSWebaNz4lc3f8g=";
    };
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      cp $src $out/share/fonts/truetype/FingerPaint-Regular.ttf
    '';
  };

in
{
  fonts.packages = [
    college-font
    mario-font
    finger-paint-font
  ];
}
