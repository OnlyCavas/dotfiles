{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  wallpapers = "${config.home.homeDirectory}/nixos-dotfiles/wallpapers";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    hypr = "hyprland";
    waybar = "waybar";
    "wal/templates" = "wal-templates";
    foot = "foot";
    betterfox = "betterfox";
    nvim = "nvim";
    doom = "doom";
    rofi = "rofi";
  };
  homeFiles = {
    ".tmux.conf" = "${dotfiles}/tmux/tmux.conf";
    "Pictures/Wallpapers" = wallpapers;
  };
in
{
  imports = [
    ./programs/terminal.nix
    ./programs/git.nix
    ./programs/windowManager.nix
    ./programs/gtk.nix
    ./programs/firefox.nix
    ./programs/editor.nix
    ./programs/development.nix
  ];

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.file = builtins.mapAttrs
    (name: path: {
      source = create_symlink path;
      recursive = true;
    })
    homeFiles;

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
  ];

  home.stateVersion = "25.05";
}
