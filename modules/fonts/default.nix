{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      # (nerdfonts.override { fonts = [ "Agave" "JetBrainsMono" "FiraCode" ]; })
      nerdfonts
      inter
      noto-fonts
      noto-fonts-emoji
      font-awesome
      material-icons
      termsyn
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" "Material Icons" "Noto Sans Mono" ];
        sansSerif = [ "Inter" "Noto Sans"  "Material Icons" "Noto Sans Japanese" "Noto Sans Korean" ];
        emoji = [ "Noto Color Emoji" "Material Icons" ];
      };
    };
  };
}
