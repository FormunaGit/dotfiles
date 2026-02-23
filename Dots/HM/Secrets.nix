{ ... }:
let
  keyPath = "/run/user/1000/secrets/";
in
{
  sops = {
    age.keyFile = "/home/formuna/.config/sops/age/keys.txt"; # DON'T SHARE THESE KEYS!!
    defaultSopsFile = ../secrets.json; # Secrets file, use `sops edit` to edit.
    defaultSymlinkPath = "/run/user/1000/secrets"; # Secrets path.
    defaultSecretsMountPoint = "/run/user/1000/secrets.d"; # Secrets path 2.
    secrets.email.path = keyPath + "email";
  };
}
