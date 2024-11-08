{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_6_6;
  boot.kernelParams = [
    "quiet"
    "fbcon=nodefer"
    "vt.global_cursor_default=0"
    "lsm=landlock,lockdown,yama,integrity,apparmor,bpf,tomoyo,selinux"
    "video4linux"
    # "security=selinux"
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl88xxau-aircrack
    rtl8812au
  ];

  boot.initrd.kernelModules = [ "8812au" ];
  boot.kernelModules = [ ];

  boot.kernel.sysctl = {
    # kernel.core_pattern = "core";
    # "kernel.perf_event_paranoid" = "1";
  };

  # systemd.package = pkgs.systemd.override { }; #withSelinux = true; };

  environment.systemPackages = with pkgs; [
    policycoreutils
  ];
}
