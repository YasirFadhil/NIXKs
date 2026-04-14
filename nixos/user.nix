{ config, pkgs, ... }:

let
  username = config.var.username;
in
{
  users = {
    users.${username} = {
    shell = pkgs.nushell;
    # shell = bash;
    isNormalUser = true;
    description = "${username} account";
    extraGroups = [
     "networkmanager"
     "wheel"
     "video"
     "audio"
     "libvirtd"
    ];
    };
  };
}
