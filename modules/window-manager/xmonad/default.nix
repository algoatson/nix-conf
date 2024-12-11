{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    # videoDrivers = ["nouveau"];
    xkb = {
      layout = "us";
      variant = "";
    };

    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        enableConfiguredRecompile = true;
        config = builtins.readFile ./xmonad.hs;
        extraPackages = haskellPackages: [
          haskellPackages.dbus
          haskellPackages.List
          haskellPackages.monad-logger
        ];
      };
    };
  };
}
