{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    adwaita-icon-theme
    papirus-icon-theme
    gnome-themes-extra

    bibata-cursors
  ];

  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    font = {
      name = "Inter";
      size = 11;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # ===== QT CONFIGURATION =====
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
  };

  # ===== CURSOR CONFIGURATION =====
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" ];
  };

  # ===== SESSION VARIABLES =====
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";

    GNOME_KEYRING_CONTROL = "/run/user/1000/keyring";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    GTK_THEME = "Adwaita-dark";
    NIXOS_OZONE_WL = "1";
  };
}
