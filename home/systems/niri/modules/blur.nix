{
  lib,
  pkgs,
  config,
  ...
}:
{
  programs.niri = {
    # Using config to append blur to the KDL config after all settings are merged
    config = lib.mkAfter (config.programs.niri.config + ''

blur {
  enabled = true
}
    '');
  };
}
