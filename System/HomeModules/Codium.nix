# #######################
##     Codium.nix     ##
########################
## This file manages  ##
## VSCodium, an open- ##
## source fork of     ##
## VSCode with no     ##
## trackers.          ##
########################

{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions;
      [ jnoortheen.nix-ide ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
        name = "codeium";
        publisher = "Codeium";
        version = "1.35.2";
        sha256 = "1i0lwv1n28hxy8kdqyh3jp1qzhpf5qn4kks21syl7bc9vkxpcw9w";
      }];
  };
}
