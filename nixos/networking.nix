{ config, pkgs, lib, ... }:

{
  hardware.bluetooth.enable = true;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  programs.kdeconnect.enable = true;
  programs.localsend.enable = true;
  services.blueman.enable = true;
  services.cloudflare-warp.enable = true;
  services.dbus.enable = true;
  security.polkit.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443 1935 3000 8080 8081 8292 9000 4321];
    allowedUDPPorts = [3478 3479 5678];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };

  networking = {
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
    hosts = {
      "127.0.0.1" = ["localhost"];
    };
  };

 environment.systemPackages = with pkgs; [
  networkmanagerapplet
 ];
}
