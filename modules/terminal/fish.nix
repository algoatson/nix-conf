{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # fishPlugins.z
    fishPlugins.tide
    fishPlugins.sponge
    fishPlugins.fzf
    fishPlugins.done
    fishPlugins.colored-man-pages
    fishPlugins.clownfish
    fishPlugins.bobthefisher
    fishPlugins.bass
    fishPlugins.autopair
    fishPlugins.async-prompt
    zoxide
    direnv
    figlet
    lolcat
    cowsay
  ];

}
