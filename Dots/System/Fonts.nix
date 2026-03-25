{ pkgs, ... }:
let
  college-font = pkgs.fetchzip {
    url = "https://dl.dafont.com/dl/?f=college";
    extension = "zip";
    hash = "sha256-1VQUFR6CAhTtL/J7SMOlBbNQ1Eh9gVCYgz08r3dw91M=";
    stripRoot = false;
  };
in
{
  fonts.packages = [
    college-font
  ];
}
