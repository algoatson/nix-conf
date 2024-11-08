{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zoxide
    direnv
    figlet
  ];

}
