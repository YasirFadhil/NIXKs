{lib, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../home/var.nix
    ../../nixos/audio.nix
    ../../nixos/bootloader.nix
    ../../nixos/chromebook.nix
    ../../nixos/environment.nix
    ../../nixos/intel.nix
    ../../nixos/localization.nix
    ../../nixos/networking.nix
    ../../nixos/power-button.nix
    ../../nixos/session-manager.nix
    ../../nixos/user.nix
    ../../nixos/zram.nix
    # ../../nixos/virtual.nix
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
    cores = 2;

    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  powerManagement.cpuFreqGovernor = "schedutil";

  security.sudo = {
    extraConfig = ''
      Defaults pwfeedback
      Defaults insults
    '';
  };

  environment.etc."libvirt/secret.conf".text = ''
    encrypt_data = 0
  '';

  # Install some programs.
  programs = {
    # steam = {
    # enable = true;
    # remotePlay.openFirewall = true;
    # dedicatedServer.openFirewall = true;
    # extraCompatPackages = with pkgs; [
    # proton-ge-bin
    # ];
    # };
    gamemode.enable = true;
  };

  fileSystems."/home/yasirfadhil/.cache" = {
    device = "/dev/disk/by-uuid/10c47c32-61e3-48ad-b110-25c12dddfd76";
    fsType = "btrfs";
    options = [
      "subvol=@cache"
      "compress=zstd:3"
      "noatime"
      "nofail"
      "x-systemd.device-timeout=5s"
      "x-systemd.automount"
    ];
  };

  fileSystems."/home/yasirfadhil/Downloads" = {
    device = "/dev/disk/by-uuid/10c47c32-61e3-48ad-b110-25c12dddfd76";
    fsType = "btrfs";
    options = [
      "subvol=@downloads"
      "compress=zstd:3"
      "noatime"
      "nofail"
      "x-systemd.device-timeout=5s"
      "x-systemd.automount"
    ];
  };

  fileSystems."/".options = ["compress=zstd:3" "noatime"];

  systemd.tmpfiles.rules = [
    "d /home/yasirfadhil/.cache 0755 yasirfadhil users -"
    "d /home/yasirfadhil/Downloads 0755 yasirfadhil users -"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.17"
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam-unwrapped"
    ];

  hardware.enableRedistributableFirmware = true;
  # hardware.enableAllFirmware = true;
  system.stateVersion = "26.05";
}
