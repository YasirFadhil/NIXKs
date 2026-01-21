{ pkgs, config, ... }:

{
  # IBus configuration to suppress Wayland startup notifications
  # If you need input methods (Chinese, Japanese, etc.), configure them here

  # Disable IBus startup notification on Wayland
  dconf.settings = {
    "org/freedesktop/ibus/general" = {
      preload-engines = [];
      engines-order = [];
    };
  };
}
