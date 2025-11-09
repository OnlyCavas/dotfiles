{ config, lib, pkgs, ... }:

{
  options.modules.hyprland.enable = lib.mkEnableOption "Hyprland compositor";

  config = lib.mkIf config.modules.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    security.polkit.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      config = {
        common.default = [ "gtk" ];
        hyprland.default = [ "hyprland" "gtk" ];
      };
    };

    services.gnome.gnome-keyring = {
      enable = true;
    };

    environment.sessionVariables = rec {
      GNOME_KEYRING_CONTROL = "/run/user/$UID/keyring";
    };

    security.pam.services.ly = {
      enableGnomeKeyring = true;
      gnupg.enable = true;
    };

    security.pam.services.hyprland.enableGnomeKeyring = true;

    environment.systemPackages = with pkgs; [
      # wayland
      waybar
      grim
      slurp
      wl-clipboard

      # hyprland especific
      swww
      hyprlock
      hypridle

      networkmanagerapplet
    ];
  };
}
