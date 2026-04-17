{ config, pkgs, ... }:

{
  # Enable video drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;

    # Prime config
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };

  # Gpu order
  environment.sessionVariables = {
    WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
  };

  # Chip intel
  hardware.cpu.intel.updateMicrocode = true;

  # Audio drivers config
  environment.systemPackages = with pkgs; [
    sof-firmware
    alsa-firmware
    alsa-utils
  ];

  boot.kernelParams = [ 
    "snd_intel_dspcfg.dsp_driver=1" 
  ];

}
