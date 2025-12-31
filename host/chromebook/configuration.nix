{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../home/var.nix
      ../../nixos/audio.nix
      ../../nixos/bootloader.nix
      ../../nixos/environment.nix
      ../../nixos/intel.nix
      ../../nixos/localization.nix
      ../../nixos/networking.nix
      ../../nixos/power-button.nix
      ../../nixos/session-manager.nix
      ../../nixos/user.nix
      # ../../nixos/virtual.nix
    ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  hardware.enableAllFirmware = true;
  system.stateVersion = "25.05";

}
