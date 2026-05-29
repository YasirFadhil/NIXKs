{ pkgs, config, ... }:
{
  programs = {
    nushell = {
      enable = true;
      configFile.text = ''
        # config.nu

        # $env.config.show_banner = false
        $env.config = ($env.config | upsert show_banner false)

        source ~/.zoxide.nu
        source ~/.cache/carapace/init.nu
        mkdir ($nu.data-dir | path join "vendor/autoload")
        starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

        def gup [] {
          let msg = (input "Commit message: ")
          git add .
          git commit -m $msg
          git push -u origin main
        }

        def gum [] {
          let msg = (input "Commit message: ")
          git add .
          git commit -m $msg
          git push -u origin master
        }

        def gme [] {
          git fetch --all
          git checkout main
          git pull origin main
          git checkout master
          git rebase main
          git checkout main
          git merge master --ff-only
          git push origin main
        }

        #alias shortcut
        alias ll = clear
        alias l = clear
        alias sl = ls

        #git
        alias g = git
        alias gad = git add .
        alias gcm = git commit -m "."
        alias gpm = git push -u origin main
        alias gps = git push -u origin master
        alias gcl = git clone

        #other
        alias cd = z
        alias zed = zeditor .
        alias nh-clean = nh clean all --keep 3

        # Dynamic aliases with username from var.nix
        alias nh-switch = nh os switch /home/${config.var.username}/.config/nixos -H nixosss --ask
        alias cdn = cd ~/.config/nixos
      '';
      envFile.text = ''
        zoxide init nushell | save -f ~/.zoxide.nu

        $env.PATH | append "/home/${config.var.username}/.nix-profile/bin"

        $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
        mkdir ~/.cache/carapace
        carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
      '';
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    starship = {
      enable = true;
    };
  };
}
