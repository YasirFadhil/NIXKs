{ config, pkgs, ... }:
{
  config = {
    services.logind.settings.Login = {
      HandlePowerKey = "ignore";
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "ignore";
    };

    # Enable ACPI daemon to handle lid switch events
    services.acpid.enable = true;

    # Custom ACPI event handler for lid switch
    environment.etc."acpi/events/lid".text = ''
      event=button/lid
      action=/etc/acpi/lid-handler.sh %e
    '';

    environment.etc."acpi/lid-handler.sh" = {
      mode = "0755";
      text = ''
        #!/bin/sh
        LID_STATE=$(cat /proc/acpi/button/lid/LID/state | awk '{print $NF}')

        if [ "$LID_STATE" = "closed" ]; then
          # Lid is closing - lock screen and turn off display
          export DISPLAY=:0
          export XAUTHORITY=/home/$(whoami)/.Xauthority

          # Lock the screen using loginctl
          ${pkgs.systemd}/bin/loginctl lock-session 2>/dev/null || true

          # Turn off display
          ${pkgs.xorg.xset}/bin/xset display off 2>/dev/null || true

        elif [ "$LID_STATE" = "open" ]; then
          # Lid is opening - add 2 second delay before turning on display
          sleep 2

          export DISPLAY=:0
          export XAUTHORITY=/home/$(whoami)/.Xauthority

          # Turn on display
          ${pkgs.xorg.xset}/bin/xset display on 2>/dev/null || true
        fi
      '';
    };

    system.activationScripts.lidHandlerScript = ''
      chmod +x /etc/acpi/lid-handler.sh
    '';
  };
}
