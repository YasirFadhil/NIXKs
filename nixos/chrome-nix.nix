# chrome-device.nix
{ config, pkgs, lib, ... }: 

let
  # Cara yang lebih elegan dan aman untuk NixOS modern
  cb-ucm-conf = pkgs.alsa-ucm-conf.overrideAttrs (old: {
    wttsrc = pkgs.fetchFromGitHub {
      owner = "WeirdTreeThing";
      repo = "alsa-ucm-conf-cros";
      rev = "6b395ae73ac63407d8a9892fe1290f191eb0315b";
      hash = "sha256-GHrK85DmiYF6FhEJlYJWy6aP9wtHFKkTohqt114TluI=";
    };
    
    postInstall = ''
      ${old.postInstall or ""}
      # Menyalin peta DSP khusus Chromebook ke dalam paket ALSA bawaan
      cp -r $wttsrc/ucm2/* $out/share/alsa/ucm2/
    '';
  }); 
in
{
  # 1. Memaksa kernel menggunakan mesin driver SOF (Sound Open Firmware)
  boot = {
    extraModprobeConfig = ''
      options snd-intel-dspcfg dsp_driver=3
    '';
  };

  # 2. Pemetaan keyboard khusus Chromebook (Keyd)
  services.keyd = {
    enable = true;
    keyboards.internal = {
      ids = [
        "k:0001:0001" "k:18d1:5044" "k:18d1:5052" "k:0000:0000"
        "k:18d1:5050" "k:18d1:504c" "k:18d1:503c" "k:18d1:5030"
        "k:18d1:503d" "k:18d1:505b" "k:18d1:5057" "k:18d1:502b"
        "k:18d1:5061"
      ];
      settings = {
        main = {
          f1 = "back"; f2 = "forward"; f3 = "refresh"; f4 = "f11";
          f5 = "scale"; f6 = "brightnessdown"; f7 = "brightnessup";
          f8 = "mute"; f9 = "volumedown"; f10 = "volumeup";
          back = "back"; forward = "forward"; refresh = "refresh";
          zoom = "f11"; scale = "scale"; brightnessdown = "brightnessdown";
          brightnessup = "brightnessup"; mute = "mute";
          volumedown = "volumedown"; volumeup = "volumeup"; sleep = "coffee";
        };
        meta = {
          f1 = "f1"; f2 = "f2"; f3 = "f3"; f4 = "f4"; f5 = "f5";
          f6 = "f6"; f7 = "f7"; f8 = "f8"; f9 = "f9"; f10 = "f10";
          back = "f1"; forward = "f2"; refresh = "f3"; zoom = "f4";
          scale = "f5"; brightnessdown = "f6"; brightnessup = "f7";
          mute = "f8"; volumedown = "f9"; volumeup = "f10"; sleep = "f12";
        };
        alt = {
          backspace = "delete"; meta = "capslock";
          brightnessdown = "kbdillumdown"; brightnessup = "kbdillumup";
          f6 = "kbdillumdown"; f7 = "kbdillumup";
        };
        control = {
          f5 = "print"; scale = "print";
        };
        controlalt = {
          backspace = "C-A-delete";
        };
      };
    };
  };

  # 3. Menerapkan paket audio
  environment = {
    systemPackages = [ pkgs.sof-firmware ];
    sessionVariables.ALSA_CONFIG_UCM2 = "${cb-ucm-conf}/share/alsa/ucm2";
  };

  # 4. Sledgehammer: Mengganti ALSA system-wide (wajib untuk > 24.05)
  system.replaceRuntimeDependencies = [
    ({
      original = pkgs.alsa-ucm-conf;
      replacement = cb-ucm-conf;
    })
  ];
}
