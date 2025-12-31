{ config, ... }:
{
  config = {
    services.logind.settings.Login.HandlePowerKey = config.var.powerKeyAction;
  };
}
