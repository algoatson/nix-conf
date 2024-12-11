{ config, lib, ... }:

{
  services.xserver = {
    videoDrivers = ["nvidia"];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.xfce.enableScreenSaver = true;
  programs.thunar.enable = true;
}
