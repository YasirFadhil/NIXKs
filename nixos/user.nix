{ config, pkgs, ... }:

let
  username = config.var.username;
in
{
  users = {
    users.${username} = {
    # shell = pkgs.zsh;
    shell = pkgs.nushell;
    # shell = pkgs.bash;
    isNormalUser = true;
    description = "${username} account";
    extraGroups = [
     "networkmanager"
     "wheel"
     "video"
     "audio"
     "libvirtd"
     "adbusers"
     "input"
    ];
    };
  };
}
