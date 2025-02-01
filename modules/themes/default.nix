{ pkgs, ... }:

{
  # Enable Theme
  environment.variables.GTK_THEME = "catppuccin-macchiato-lavender-standard+default";
  environment.variables.XCURSOR_THEME = "catppuccin-macchiato-lavender-cursors";
  environment.variables.XCURSOR_SIZE = "22";
  environment.variables.HYPRCURSOR_THEME = "catppuccin-macchiato-lavender-cursors";
  environment.variables.HYPRCURSOR_SIZE = "22";
  qt.enable = true;
  qt.platformTheme = "gnome"; # "gtk2";
  qt.style = "breeze"; # "gtk2"
  console = {
    earlySetup = true;
    colors = [
      "24273a"
      "ed8796"
      "a6da95"
      "eed49f"
      "8aadf4"
      "f5bde6"
      "8bd5ca"
      "cad3f5"
      "5b6078"
      "ed8796"
      "a6da95"
      "eed49f"
      "8aadf4"
      "f5bde6"
      "8bd5ca"
      "a5adcb"
    ];
  };

  # Override packages
  nixpkgs.config.packageOverrides = pkgs: {
    colloid-icon-theme = pkgs.colloid-icon-theme.override { colorVariants = [ "all" ]; };
    catppuccin-gtk = pkgs.catppuccin-gtk.override {
      accents = [ "lavender" ]; # You can specify multiple accents here to output multiple themes
      size = "standard";
      variant = "macchiato";
    };
    discord = pkgs.discord.override {
      withOpenASAR = true;
      withTTS = true;
    };
  };

  environment.systemPackages = with pkgs; [
    numix-icon-theme-circle
    colloid-icon-theme
    catppuccin-gtk
    catppuccin-kvantum
    catppuccin-cursors.macchiatoLavender
    themechanger
    xsettingsd
    gnome-tweaks
    gnome-shell
    gnome-shell-extensions
    jgmenu
    conky
  ];

  systemd.user.services.xsettingsd = {
    enable = true;
    description = "XSettings Daemon";
    serviceConfig = {
      ExecStart = "${pkgs.xsettingsd}/bin/xsettingsd";
      Restart = "always";
    };
    wantedBy = [ "default.target" ];
  };
}
