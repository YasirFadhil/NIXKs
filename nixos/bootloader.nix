{ config, pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        # extraEntries = {
        #   "arch.conf" = ''
        #     title Arch Linux
        #     linux /vmlinuz-linux
        #     initrd /initramfs-linux.img
        #     options root=UUID=b8deec5c-6601-4c78-b81f-ac2d7dd9b1be rw snd_intel_dspcfg.dsp_driver=3
        #   '';
        # };
      };
      efi.canTouchEfiVariables = true;
    };
    plymouth = {
      enable = false;
      theme = "mac-style";
      themePackages = [ pkgs.mac-style-plymouth ];
    };
    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackages_zen;
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
    kernelParams = [
      "snd_intel_dspcfg.dsp_driver=3"
    ];
  };
}
