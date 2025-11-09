{ config, lib, pkgs, ... }:

{
  options.modules.virtualization.enable = lib.mkEnableOption "Virtualization compositor";

  config = lib.mkIf config.modules.virtualization.enable {

    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;

      dockerSocket.enable = true;

      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    systemd.sockets.podman.wantedBy = lib.mkForce [ ];
    systemd.user.sockets.podman.wantedBy = lib.mkForce [ ];
    systemd.sockets.docker.wantedBy = lib.mkForce [ ];

    systemd.user.services.podman = {
      enable = true;
      wantedBy = lib.mkForce [ ];
    };

    environment.systemPackages = with pkgs; [
      podman-compose
      lazydocker
    ];

    users.users.deadshot.extraGroups = [ "podman" ];
    boot.kernelParams = [ "systemd.unified_cgroup_hierarchy=1" ];
  };
}
