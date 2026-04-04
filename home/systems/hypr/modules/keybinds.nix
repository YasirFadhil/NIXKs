{
  config,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      bindl = [
        "XF86AudioRaiseVolume, exec, noctala-shell ipc volume increase"
        "XF86AudioLowerVolume, exec, noctala-shell ipc volume decrease"
        "XF86AudioMute, exec, noctala-shell ipc volume mute"
        "XF86MonBrightnessUp, exec, noctala-shell ipc brightness increase"
        "XF86MonBrightnessDown, exec, noctala-shell ipc brightness decrease"
      ];

      bind = [
        "SUPER, T, exec, foot"
        "SUPER, Q, killactive,"
        "SUPER SHIFT, Q, exit,"
        "SUPER, E, exec, nautilus"
        "SUPER SHIFT, F, togglefloating,"
        "SUPER, SPACE, exec, noctalia-shell ipc call launcher toggle"
        "SUPER, P, exec, noctala-shell ipc call sessionMenu toggle"
        "SUPER, V, exec, noctala-shell ipc call launcher clipboard"
        "SUPER SHIFT, E, exec, noctala-shell ipc call launcher emoji"
        "SUPER, L, exec, noctalia-shell ipc call lockScreen lock"

        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"

        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };
  };
}
