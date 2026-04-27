{ config, lib, pkgs, ... }:

{
  # Configure zram for compressed swap
  zramSwap = {
    enable = true;
    # Compression algorithm: "zstd" (default), "lz4", or "lzo"
    algorithm = "zstd";
    # Memory to allocate for zram (in MB)
    # Default is 1/2 of available RAM
    memoryPercent = 100;
    # Priority for zram swap (higher = preferred)
    priority = 32767;
  };
  
  # swapDevices = [{
  #   device = "/var/lib/swapfile";
  #   size = 8192;
  #   priority = 5;
  # }];

  # Optional: Configure swappiness (0-100, lower = less swapping)
  # Only swap when necessary
  boot.kernel.sysctl = {
    "vm.swappiness" = 100;
    "vm.page-cluster" = 0;
  };
}
