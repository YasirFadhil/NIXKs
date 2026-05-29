{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver   # Primary VA-API driver for hardware acceleration
      intel-vaapi-driver   # Fallback driver
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
    vulkan-tools
  ];
}

