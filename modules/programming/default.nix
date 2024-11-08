{ config, pkgs, ... }:
{
  imports = [
    # ./rust.nix
    ./lsp.nix
  ];

  environment.systemPackages = with pkgs; [
    tokei   # count your code
    mdcat   # cat for markdown
  ];
}
