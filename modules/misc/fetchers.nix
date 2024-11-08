{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    onefetch
    bfetch
    ipfetch
    afetch
    hayabusa
    owofetch
    maxfetch
    bunnyfetch
    yafetch
    fastfetch
    leaf
    nitch
    disfetch
    ghfetch
    cpufetch
    fet-sh
    nerdfetch
    ramfetch
    starfetch
    octofetch
    htop
    bottom
    btop
    zfxtop
    kmon

    # vulkan-tools
    # opencl-info
    # clinfo
    # vdpauinfo
    # libva-utils
    # nvtop
    gpu-viewer
    dig
    speedtest-rs
  ];
}
