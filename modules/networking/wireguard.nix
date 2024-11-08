{ pkgs, lib, config, ... }:

{
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
    allowedTCPPorts = [ 51820 ];
  };

  networking.wireguard.enable = false;
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.73.33.213/32" ];
      dns = [ "10.0.0.69" ];
      listenPort = 51820;
      privateKey = "insert key here";
      peers = [
        {
          publicKey = "XOedjVJaT2IrEDJbzvtZeL4hP5uPRHzFxvD1cwVwUFo=";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "169.150.227.197:51820";
        }
        {
          publicKey = "yxyntWsANEwxeR0pOPNAcfWY7zEVICZe9G+GxortzEY=";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "149.88.22.129:51820";
        }
        # gaming: canada
        {
        publicKey = "TUCaQc26/R6AGpkDUr8A8ytUs/e5+UVlIVujbuBwlzI=";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "146.70.198.66:51820";
        }
        # regular: switzerland
        {
          publicKey = "qcvI02LwBnTb7aFrOyZSWvg4kb7zNW9/+rS6alnWyFE=";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "193.32.127.67:51820";
        }
        # {
        #   publicKey = "bPfJDdgBXlY4w3ACs68zOMMhLUbbzktCKnLOFHqbxl4=";
        #   allowedIPs = [ "0.0.0.0/0" ];
        #   endpoint = "31.171.153.66:51820";
        # }
      ];
    };
  };
}
