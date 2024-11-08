{ lib, config, pkgs, ... }:
{
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      mpv = {
        executable = "${pkgs.mpv}/bin/mpv";
        profile = "${pkgs.firejail}/etc/firejail/mpv.profile";
      };
      imv = {
        executable = "${pkgs.imv}/bin/imv";
        profile = "${pkgs.firejail}/etc/firejail/imv.profile";
      };
      zathura = {
        executable = "${pkgs.zathura}/bin/zathura";
        profile = "${pkgs.firejail}/etc/firejail/zathura.profile";
      };
      discord = {
        executable = "${pkgs.discord}/bin/discord";
        profile = "${pkgs.firejail}/etc/firejail/discord.profile";
      };
      slack = {
        executable = "${pkgs.slack}/bin/slack";
        profile = "${pkgs.firejail}/etc/firejail/slack.profile";
      };
      telegram-desktop = {
        executable = "${pkgs.tdesktop}/bin/telegram-desktop";
        profile = "${pkgs.firejail}/etc/firejail/telegram-desktop.profile";
      };
      brave = {
        executable = "${pkgs.brave}/bin/brave";
        profile = "${pkgs.firejail}/etc/firejail/brave.profile";
      };
      qutebrowser = {
        executable = "${pkgs.qutebrowser}/bin/qutebrowser";
        profile = "${pkgs.firejail}/etc/firejail/qutebrowser.profile";
      };
      librewolf = {
        executable = "${pkgs.librewolf}/bin/librewolf";
        profile = "${pkgs.firejail}/etc/firejail/librewolf.profile";
      };
      vscodium = {
        executable = "${pkgs.vscodium}/bin/vscodium";
        profile = "${pkgs.firejail}/etc/firejail/vscodium.profile";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    firejail
  ];
}
