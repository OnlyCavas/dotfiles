{ config, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./hyprland.nix
    ./nvidia.nix
    ./virtualization.nix
    ./security.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;

    systemd-boot.configurationLimit = 5;
  };

  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      logRefusedConnections = true;
      logRefusedPackets = false;
      allowPing = false;
    };
  };

  console.keyMap = "pt-latin1";
  time.timeZone = "Europe/Lisbon";
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    xserver.xkb = {
      layout = "pt";
      variant = "";
    };
  };

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "doom";
      hide_borders = true;
    };
  };

  programs.zsh.enable = true;
  programs.dconf.enable = true;

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      inter

      # nerd fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.code-new-roman
      nerd-fonts.symbols-only

      # system fonts
      noto-fonts
      noto-fonts-emoji
    ];
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git

    libnotify
    libsecret
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
