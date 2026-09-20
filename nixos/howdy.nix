# ~/.config/nixos/nixos/session-manager.nix (atau modul baru)
{ config, pkgs, ... }:

{
  # Aktifkan Howdy Service & PAM
  services.howdy = {
    enable = true;
    package = pkgs.howdy;
    control = "sufficient"; # Cukup wajah saja untuk unlock
    settings = {
      core = {
        no_confirmation = true;  # Langsung unlock tanpa perlu tekan Enter
        abort_if_ssh = true;
        abort_if_lid_closed = true;
      };
      video = {
        device_path = "/dev/video0"; # HP TrueVision HD Camera
        certainty = 3.5;             # Ambang akurasi default yang seimbang
        timeout = 4;                 # Timeout 4 detik sebelum fallback ke password
        max_height = 320;            # Ringan untuk Celeron N4020
        recording_plugin = "opencv";
      };
    };
  };

  # Pastikan PAM service login dan hyprlock/swaylock mengizinkan Howdy
  security.pam.services.login.howdy.enable = true;
  security.pam.services.hyprlock.howdy.enable = true;
}

