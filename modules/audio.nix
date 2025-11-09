{ config, lib, pkgs, ... }:

{
  options.modules.audio.enable = lib.mkEnableOption "Audio Configuration";

  config = lib.mkIf config.modules.audio.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pavucontrol
    ];
  };
}
