{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      # --- Screenshots / blur background ---
      screenshots = true;
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";

      # --- Clock ---
      clock = true;
      timestr = "%H:%M";
      datestr = "%A, %d %B %Y";

      # --- Fade in ---
      fade-in = 0.2;

      # --- Colors (Dracula-inspired dark palette) ---
      # Inside ring / key area
      inside-color = "282a3600";
      inside-clear-color = "282a3600";
      inside-caps-lock-color = "282a3600";
      inside-ver-color = "282a3600";
      inside-wrong-color = "ff555500";

      # Ring
      ring-color = "6272a4aa";
      ring-clear-color = "8be9fdaa";
      ring-caps-lock-color = "ffb86caa";
      ring-ver-color = "50fa7baa";
      ring-wrong-color = "ff5555aa";

      # Line (separator between inside and ring)
      line-uses-ring = false;
      line-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";

      # Text
      text-color = "f8f8f2cc";
      text-clear-color = "8be9fdcc";
      text-caps-lock-color = "ffb86ccc";
      text-ver-color = "50fa7bcc";
      text-wrong-color = "ff5555cc";

      # Key highlight
      key-hl-color = "50fa7b88";
      bs-hl-color = "ff555588";
      caps-lock-key-hl-color = "ffb86c88";
      caps-lock-bs-hl-color = "ff555588";

      # Separator
      separator-color = "00000000";

      # --- Layout ---
      layout-bg-color = "00000000";
      layout-border-color = "00000000";
      layout-text-color = "f8f8f2cc";

      # --- Indicator ---
      indicator-radius = 100;
      indicator-thickness = 10;
      indicator-caps-lock = true;

      # --- Font ---
      font = "SF Pro Display";
      font-size = 20;

      # --- Grace period (seconds before lock fully activates) ---
      grace = 2;
      grace-no-mouse = true;
      grace-no-touch = true;
    };
  };
}
