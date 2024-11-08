{ pkgs, ... }:

{
  services.tor = {
    enable = true;
    client.enable = true;
    enableGeoIP = false;
    settings."MapAddress" = [
        "palladium.libera.chat libera75jm6of4wxpxt4aynol3xjmbtxgfyjpu34ss4d7r7q2v5zrpyd.onion"
        # "c001.ca75 w7xzewfxylftijrpcprlbcdwokluxadp4jusqeinixvo6q3cpornbsid.onion"
    ];
  };

  environment.systemPackages = with pkgs; [
    tor
    torsocks proxychains
  ];
}
