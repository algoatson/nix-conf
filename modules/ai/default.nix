{ pkgs, ... }:
{


  environment.systemPackages = with pkgs; [
    tgpt
  ];
}
