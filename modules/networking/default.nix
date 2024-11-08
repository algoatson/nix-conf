{ pkgs, ... }:

{
  imports = [
    # ./mac-changer.nix
    ./dns.nix
    ./vpn.nix
    ./vnc.nix
    ./ssh.nix
    ./tor.nix
    ./tls.nix
    ./mitm.nix
    ./sniffers.nix
    ./tunneling.nix
    ./wireguard.nix
  ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://10.0.0.69:8888/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.hostName = "nixos";

  # Enable networking.
  networking.networkmanager.enable = true;

  # Enables wireless support via wpa_supplicant.
  networking.wireless.enable = true;

  networking.resolvconf.enable = true;

  # Extra hosts
  networking.extraHosts = ''
    # 172.105.99.41 cia.gov
  '';

  networking = {
    # interfaces = {
    #   veth0 = {
    #     # enable = true;
    #     ipv4 = {
    #       addresses = [
    #         {
    #           address = "10.0.0.62";
    #           prefixLength = 16;
    #         }
    #       ];
    #       routes = [
    #         {
    #           options.scope = "global";
    #           address = "10.0.0.1";
    #           prefixLength = 16;
    #         }
    #       ];
    #     };
    #   };
    # };
    nat = {
      enable = true;
      internalInterfaces = [ "wpl0s20f0u8" ]; # "veth0";
      externalInterface = "wg0";
    };
  };

  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  networking.firewall.allowedTCPPorts = [ 6600 24800 ];
  networking.firewall.allowedUDPPorts = [ 24800 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  environment.systemPackages = with pkgs; [
    # network utilities
    arping
    arpoison
    atftp
    bandwhich
    bngblaster
    crackmapexec
    evillimiter
    iperf2
    iputils
    lftp
    mitm6
    mtr
    ncftp
    netcat-gnu
    netdiscover
    netexec
    nload
    nuttcp
    pingu
    putty
    pwnat
    responder
    route-graph
    rustcat
    sshping
    sslh
    sshpass
    tunnelgraf
    wbox
    whois
    yersinia
    # packet generators
    boofuzz
    gping
    fping
    hping
    ostinato
    pktgen
  ];
}
