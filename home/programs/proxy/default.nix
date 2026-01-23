{ config, pkgs, lib, ... }:

{
  # Home-manager proxy configuration
  # This module configures proxy settings for user applications

  home.sessionVariables = {
    # Proxy environment variables will be loaded from shell init
    # if /etc/proxy-credentials exists
  };

  programs.bash.initExtra = ''
    # Load proxy credentials if available
    if [ -f /etc/proxy-credentials ]; then
      CREDS=$(cat /etc/proxy-credentials)
      export http_proxy="http://''${CREDS}@pl21.speedycdn.space:13540"
      export https_proxy="http://''${CREDS}@pl21.speedycdn.space:13540"
      export HTTP_PROXY="http://''${CREDS}@pl21.speedycdn.space:13540"
      export HTTPS_PROXY="http://''${CREDS}@pl21.speedycdn.space:13540"
      export NO_PROXY="127.0.0.1,localhost,127.0.0.0/8,::1,0.0.0.0"
    fi
  '';

  programs.zsh.initExtra = ''
    # Load proxy credentials if available
    if [ -f /etc/proxy-credentials ]; then
      CREDS=$(cat /etc/proxy-credentials)
      export http_proxy="http://''${CREDS}@pl21.speedycdn.space:13540"
      export https_proxy="http://''${CREDS}@pl21.speedycdn.space:13540"
      export HTTP_PROXY="http://''${CREDS}@pl21.speedycdn.space:13540"
      export HTTPS_PROXY="http://''${CREDS}@pl21.speedycdn.space:13540"
      export NO_PROXY="127.0.0.1,localhost,127.0.0.0/8,::1,0.0.0.0"
    fi
  '';

  # Git proxy configuration
  programs.git.extraConfig = {
    http = {
      proxy = "http://pl21.speedycdn.space:13540";
    };
    https = {
      proxy = "http://pl21.speedycdn.space:13540";
    };
  };

  # Wget configuration
  home.file.".wgetrc" = {
    text = ''
      # Wget proxy configuration
      http_proxy = http://pl21.speedycdn.space:13540
      https_proxy = http://pl21.speedycdn.space:13540
      use_proxy = on
    '';
  };

  # Curl configuration
  home.file.".curlrc" = {
    text = ''
      # Curl proxy configuration
      proxy = "http://pl21.speedycdn.space:13540"
    '';
  };
}
