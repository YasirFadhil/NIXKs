{ pkgs, ... }:
{
  # Intel UHD Graphics 600 (Gemini Lake N4020) configuration
  boot = {
    initrd.kernelModules = [ ];
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
      vpl-gpu-rt
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
    libva-utils
  ];
}
