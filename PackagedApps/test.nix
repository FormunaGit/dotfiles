let
  pkgs = import <nixpkgs> {};
in
pkgs.callPackage ./borked3ds.nix {}

