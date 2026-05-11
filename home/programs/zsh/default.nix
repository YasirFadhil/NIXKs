{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    enableVteIntegration = true;

    history = {
      size = 10000;
      save = 10000;
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      ignoreSpace = true;
    };

    shellAliases = {
      # Clear screen (matching nushell)
      ll = "clear";
      l = "clear";
      sl = "ls";

      # Git aliases (matching nushell)
      g = "git";
      gad = "git add .";
      gcm = "git commit -m"; # Note: use as 'gcm "message"'
      gps = "git push -u origin main";
      gcl = "git clone";

      # Navigation
      zed = "zeditor .";

      # NixOS (matching nushell style)
      nhs = "nh os switch /home/yasirfadhil/.config/nixos -H nixos --ask";
      cdn = "cd /home/yasirfadhil/.config/nixos";
      nh-switch = "nh os switch /home/yasirfadhil/.config/nixos -H nixos --ask";
      nh-clean = "nh clean all --keep 3";
      nix-search = "nix-shell -p";

      # System utilities
      ls = "ls --color=auto";
      la = "ls -la";
      grep = "grep --color=auto";
    };

    initContent = ''
      # Options
      setopt HIST_FIND_NO_DUPS
      setopt HIST_IGNORE_DUPS
      setopt SHARE_HISTORY

      # Keybindings
      bindkey -e
      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward

      # Additional customization here
    '';

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
        file = "zsh-autosuggestions.plugin.zsh";
      }
      {
        name = "zsh-history-substring-search";
        src = "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search";
        file = "zsh-history-substring-search.plugin.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh";
      }
    ];
  };

  # Starship prompt integration
  programs.starship = {
    enable = true;
  };
}
