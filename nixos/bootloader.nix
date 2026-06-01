{ config, pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };

    # Force early loading of the Intel graphics driver to prevent switch-root freezes
    initrd.kernelModules = [  ];

    # Linux 6.12 is good, but if freezes persist, uncomment the LTS line below
    # kernelPackages = pkgs.linuxPackages_6_12;
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_zen;
    # kernelPackages = pkgs.linuxPackages_cachyos_lts;

    kernelParams = [
      "snd_intel_dspcfg.dsp_driver=3"
      # "i915.mitigations=off"
      # "intel_iommu=igfx_off"          # Fixed typo: changed hyphen to equals sign
      # "intel_idle.max_cstate=1"       # Prevents Gemini Lake low-power hardware freezes
      # "i915.enable_dc=0"              # Disables unstable GPU power-saving states
    ];
  };
}

