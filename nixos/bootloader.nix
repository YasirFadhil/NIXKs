{ config, pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
    
    kernel.sysctl."kernel.sysrq" = 1;

    # Removed v4l2loopback from here to prevent early-boot crash
    initrd.kernelModules = [ "i915" ];

    # Added here for safe loading after the root file system mounts
    kernelModules = [ "v4l2loopback" ];

    kernelPackages = pkgs.linuxPackages_6_18;
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=9 card_label="Android Webcam" exclusive_caps=1
    '';

    kernelParams = [
      "snd_intel_dspcfg.dsp_driver=3"
      "intel_idle.max_cstate=1"       
      "i915.enable_psr=0"
      "i915.enable_dc=0"
      "mem_sleep_default=s2idle"
      "usbcore.autosuspend=-1" 
    ];
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="mmc", ATTR{power/control}="on"
  '';
}
