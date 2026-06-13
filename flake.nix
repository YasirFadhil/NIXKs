{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qml-niri = {
      url = "github:imiric/qml-niri/main";
      inputs.nixpkgs.follows = "nixpkgs";
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
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, nixpkgs, home-manager, niri, nix4nvchad, hyprland, ... }@inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixosss = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./host/chromebook/configuration.nix
        {
          nix.settings = {
            substituters = [
              "https://hyprland.cachix.org"
              "https://niri.cachix.org"
            ];
            trusted-public-keys = [
              "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
              "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z7oezYhGhR+3W2964="
            ];
            trusted-substituters = [
              "https://hyprland.cachix.org"
              "https://niri.cachix.org"
            ];
          };
        nixpkgs.overlays = [
          (final: prev: {
            sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation rec {
              pname = "sf-mono-liga-bin";
              version = "dev";
              src = inputs.sf-mono-liga-src;
              dontConfigure = true;
              installPhase = ''
                mkdir -p $out/share/fonts/opentype
                cp -R $src/*.otf $out/share/fonts/opentype/
              '';
            };
          })

          (final: prev: {
            bun = prev.bun.overrideAttrs (oldAttrs: {
              # Use baseline build for Celeron N4020 (x86-64 without AVX)
              # Baseline build is compatible with older CPUs that don't support AVX
              src = prev.fetchurl {
                url = "https://github.com/oven-sh/bun/releases/download/bun-v1.3.13/bun-linux-x64-baseline.zip";
                sha256 = "0l67xlql0fwdz1xy71sjdxrnjprz49d0mb6s0l10js3h58lj92lx";
              };

              # Use pre-compiled binary, no build needed
              dontConfigure = true;
              dontBuild = true;
              doCheck = false;

              unpackPhase = ''
                ${prev.unzip}/bin/unzip $src
              '';

              installPhase = ''
                mkdir -p $out/bin
                cp bun-linux-x64-baseline/bun $out/bin/bun
                chmod +x $out/bin/bun
              '';
            });
          })
        ];
        }
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.yasirfadhil = import ./home/home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
        ({ pkgs, ... }: {
          programs.hyprland = {
            enable = true;
            package = pkgs.hyprland;
            portalPackage = pkgs.xdg-desktop-portal-hyprland;
          };
          programs.niri = {
            enable = true;
            package = pkgs.niri;
          };
        })
      ];
    };
  };
}
