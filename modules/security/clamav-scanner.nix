{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clamav
  ];

  services.clamav.scanner = {
    enable = true;
    interval = "Sat *-*-* 04:00:00";
  };
}
