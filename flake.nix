{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.niri-unstable.follows = "niri-blur";
    };
    niri-blur = {
      url = "github:niri-wm/niri/kde-blur-protocol";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    danksearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    freesmlauncher = {
      url = "github:FreesmTeam/FreesmLauncher";
      inputs = {
        nixpkgs = {
        follows = "nixpkgs";
        };
      };
    };
    mac-style-plymouth = {
      url = "github:SergioRibera/s4rchiso-plymouth-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, niri, nix-cachyos-kernel, nix4nvchad, freesmlauncher, hyprland, ... }@inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./host/chromebook/configuration.nix
        {
          nix.settings = {
            substituters = [ "https://attic.xuyh0120.win/lantian" "https://hyprland.cachix.org"];
            trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
            trusted-substituters = ["https://hyprland.cachix.org"];
          };
          nixpkgs.overlays = [ niri.overlays.niri inputs.mac-style-plymouth.overlays.default nix-cachyos-kernel.overlays.pinned ];
        }
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.yasirfadhil = import ./home/home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
        ({ pkgs, ... }: {
          programs.hyprland = {
            enable = false;
            package = pkgs.hyprland;
            portalPackage = pkgs.xdg-desktop-portal-hyprland;
          };
        })
      ];
    };
  };
}
