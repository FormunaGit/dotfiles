{ pkgs, ... }:
let
  college-font = pkgs.fetchzip {
    url = "https://dl.dafont.com/dl/?f=college";
    stripRoot = false;
  };
in
{
  fonts.packages = [
    college-font
  ];
}
