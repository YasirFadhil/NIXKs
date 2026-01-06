{ config, lib, pkgs, ... }:

{
  # Configure zram for compressed swap
  zramSwap = {
    enable = true;
    # Compression algorithm: "zstd" (default), "lz4", or "lzo"
    algorithm = "zstd";
    # Memory to allocate for zram (in MB)
    # Default is 1/2 of available RAM
    memoryPercent = 50;
    # Priority for zram swap (higher = preferred)
    priority = 32767;
  };

  # Optional: Configure swappiness (0-100, lower = less swapping)
  # Only swap when necessary
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };
}
```

Now add this to your `configuration.nix` by adding this line to the imports:

```
../../nixos/zram.nix
```

This will:
- Enable zram with zstd compression (most efficient)
- Use 50% of your RAM as compressed swap
- Set high priority so zram is preferred over disk swap
- Configure swappiness to 10 so the system only swaps when necessary
