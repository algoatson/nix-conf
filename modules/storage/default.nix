{ pkgs, ... }:
{
  # systemd.services.rclone-mount = {
  #   description = "Rclone mount for Google Drive";
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "network-online.target" ];
  #   serviceConfig = {
  #     ExecStart = "${pkgs.rclone}/bin/rclone mount drive:DriveSyncFiles/Obsidian /home/notrazor/Drive/ --vfs-cache-mode full --allow-non-empty --config /home/notrazor/.rclone.conf --allow-other";
  #     ExecStop = "umount -l /home/notrazor/Drive";
  #     Restart = "on-failure";
  #     RestartSec = 5;
  #   };
  # };

  environment.systemPackages = with pkgs; [
    gdrive3 drive rclone
  ];
}
