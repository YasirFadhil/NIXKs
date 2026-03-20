{ config, ... }:
{
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "nothing";
    };
  };
}
