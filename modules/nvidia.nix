{ config, lib, pkgs, ... }:

{
  options.modules.nvidia.enable = lib.mkEnableOption "Nvidia Configuration";

  config = lib.mkIf config.modules.nvidia.enable {
    hardware.graphics.enable = true;

    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    environment.systemPackages = with pkgs; [
      nvtopPackages.nvidia
    ];

    environment.sessionVariables = {
      # wayland support
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";

      # hyprland specific
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
}
