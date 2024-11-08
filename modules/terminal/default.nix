{ pkgs, ... }:

{
  imports = [
    ./fish.nix
  ];

  # wezterm can be used to set window class title
  # command = "wezterm start --always-new-process --class wezterm_scratchpad"
  environment.systemPackages = with pkgs; [
    starship
    wezterm
    cool-retro-term
    viu
    tre-command
    trash-cli
    procs
    tealdeer
    duf
    dust
    fd
    jq
    felix-fm
    chafa
    cmatrix
    pipes-rs
    rsclock
    cava
    tree
  ];
}
