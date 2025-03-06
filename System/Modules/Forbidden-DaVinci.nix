# All this for DaVinci Resolve... #
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    davinci-package.override {
      appimage-run = appimage-run.override {
        appimage-run-init = appimage-run-init.override {
          appimage-run-fhs = appimage-run-fhs.override {
            appimage-run-usr-target = appimage-run-usr-target.override {
              libsecret = libsecret.override {
                gjs = gjs.override {
                  spidermonkey = spidermonkey.override {
                    firefox = pkgs.firefox-esr;
                  };
                };
              };
            };
          };
        };
      };
    }
  ];
} # firefox spidermonkey gjs libsecret appimage-run-usr-target appimage-run-fhs appimage-run-fhs