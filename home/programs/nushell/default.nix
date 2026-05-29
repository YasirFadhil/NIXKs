{ pkgs, config, ... }:
{
  programs = {
    nushell = {
      enable = true;
      configFile.text = builtins.readFile ./config.nu + ''

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
