{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules
    ];

  networking.hostName = "lostRiver";

  users.users.deadshot = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "input"
      "audio"
      "video"
      "wireshark"
    ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };

  hardware.cpu.amd.updateMicrocode = true;

  modules = {
    # Desktop Environment
    hyprland.enable = true;

    # Hardware Configuration
    audio.enable = true;
    nvidia.enable = true;

    # development
    virtualization.enable = true;
    security.enable = true;
  };

  powerManagement.cpuFreqGovernor = "schedutil";
}
