{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    dunst
    hyprpicker

    pywal16
    imagemagick

    rofi
  ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "mouse";
        width = 300;
        offset = "10x50";
        font = "JetBrainsMono Nerd Font 10";
      };
    };
  };
}
