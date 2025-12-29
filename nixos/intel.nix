{ config, pkgs, ... }:
{
  # Intel UHD Graphics 600 (Gemini Lake N4020) configuration
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libva-intel-driver
      intel-gpu-tools
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      libva-intel-driver
    ];
  };

  # Intel CPU-specific settings
  hardware.cpu.intel.updateMicrocode = true;

  # Environment variables for Intel hardware
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
  };

  # System packages for Intel management
  environment.systemPackages = with pkgs; [
    intel-gpu-tools
    clinfo
  ];
}
