{ pkgs, ... }:

{
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  users.extraGroups.vboxusers.members = [ "notrazor" ];

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    docker virtualbox
  ];
}
