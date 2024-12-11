{ config, lib, ... }:

{
  services.xserver = {
    videoDrivers = ["nvidia"];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gnome.enable = true;
}
