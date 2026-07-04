{ 
  config, 
  pkgs, 
  ... 
}:

{
  # Enable Lid Opening to Wake the Laptop from s2idle
  systemd.services.enable-lid-wake = {
    description = "Enable Lid Switch ACPI Wakeup";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "enable-lid-wake-script" ''
        # Check if the Lid Switch wake capability exists and is disabled
        if grep -q "LID" /proc/acpi/wakeup; then
          if grep "LID" /proc/acpi/wakeup | grep -q "\*disabled"; then
            echo "LID" > /proc/acpi/wakeup
          fi
        fi
      '';
    };
  };
}

