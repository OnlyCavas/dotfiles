{ config, lib, pkgs, ... }:

{
  options.modules.security.enable = lib.mkEnableOption "Security";

  config = lib.mkIf config.modules.security.enable {

    security.apparmor = {
      enable = true;
    };

    users.users.root = {
      hashedPassword = lib.mkForce "!";
    };

    security.sudo = {
      enable = lib.mkDefault true;
      execWheelOnly = lib.mkDefault true;
      wheelNeedsPassword = lib.mkDefault true;
    };

    environment.systemPackages = with pkgs; [
      lynis
      clamav

      nethogs
      iftop
      nftables

      lsof
      wireshark
    ];

    services.fwupd.enable = true;
    networking.firewall.logRefusedConnections = true;
  };
}
