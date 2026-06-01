{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../home/var.nix
      ../../nixos/audio.nix
      ../../nixos/bootloader.nix
      ../../nixos/chrome-nix.nix
      ../../nixos/environment.nix
      ../../nixos/intel.nix
      ../../nixos/localization.nix
      ../../nixos/networking.nix
     # ../../nixos/power-button.nix
      ../../nixos/session-manager.nix
      ../../nixos/user.nix
      ../../nixos/zram.nix
      ../../nixos/virtual.nix
      ../../nixos/ventoy.nix
    ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  nix.settings = {
    experimental-features = [
    "nix-command"
    "flakes"
    ];

    max-jobs = 1;
    cores = 1;
  };

  security.sudo = {
    extraConfig = ''
      Defaults pwfeedback
      Defaults insults
    '';
  };

  # Install some programs.
  programs = {
    firefox = {
      enable = true;
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    gamemode.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.12"
  ];
  
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  system.stateVersion = "26.05";

}
