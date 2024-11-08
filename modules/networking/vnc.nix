{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    turbovnc
  ];

}
