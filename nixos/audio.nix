{ config, ... }:{

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  services.pipewire.wireplumber.extraConfig = {
  "10-fix-pro-audio" = {
    "monitor.alsa.rules" = [
      {
        matches = [ { "node.name" = "~alsa_output.*"; } ];
        actions = {
          update-props = {
            # Enable automatic port detection for speaker/headphone
            "api.acp.auto-port" = true;
            # Enable automatic profile selection
            "api.acp.auto-profile" = true;
            # Force UCM to handle the profile mapping
            "api.alsa.use-ucm" = true;
            # Allows multiple profiles/ports to be exposed
            "api.alsa.pro-audio" = false;
          };
        };
      }
    ];
  };
 };
}
