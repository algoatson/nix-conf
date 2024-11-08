{ config, lib, pkgs, ... }:

{
  services.mpd = {
    enable = true;
    user = "notrazor";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My Pipewire Output"
      }
    '';
    network.listenAddress = "any";
  };
        # server "127.0.0.1" # add this line - MPD must connect to the local sound server

  systemd.services.mpd.environment = {
    # XDG_RUNTIME_DIR = "/run/user/${toString config.users.users."notrazor".uid}"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
    XDG_RUNTIME_DIR = "/run/user/1000"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
  };

  environment.systemPackages = with pkgs; [
    mpd
    spotify
    libmpdclient
    mpd-discord-rpc
    ncmpcpp
    mpc-cli
    cantata
    spotdl
  ];

  systemd.user.services.mpd-discord-rpc = {
    enable = true;
    description = "MPD Discord RPC";
    serviceConfig = {
      ExecStart = "${pkgs.mpd-discord-rpc}/bin/mpd-discord-rpc";
      Restart = "always";
    };
    wantedBy = [ "default.target" ];
  };

}
