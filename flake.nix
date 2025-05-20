{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    catppuccin.url = "github:catppuccin/nix";

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    ez-configs = {
      url = "github:karpfediem/ez-configs/badidea";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    nixvim = {
      #     url = "github:nix-community/nixvim";
      #     inputs = {
      #       nixpkgs.follows = "nixpkgs-unstable";
      #       home-manager.follows = "home-manager";
      #     };
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      url = "github:nix-community/nixvim/nixos-24.11";
    };
    nixified-ai = {
      url = "github:nixified-ai/flake";
    };

    fw-fanctrl = {
      url = "github:TamtamHero/fw-fanctrl/packaging/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ flake-parts, system-manager, ez-configs, fw-fanctrl, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ez-configs.flakeModule
      ];

      systems = [ ];

      flake = {
        systemConfigs.default = system-manager.lib.makeSystemConfig {
          modules = [
            ./system-modules
          ];
        };
      };

      ezConfigs = {
        root = ./.;
        globalArgs = { inherit inputs; };
        nixos.hosts = {
          aquarium = {
            userHomeModules = [ "carp" ];
            extraModules = [ inputs.nixified-ai.nixosModules.comfyui ];
          };
          calm-otter.userHomeModules = [ "carp" ];
          coy-koi.userHomeModules = [ "carp" ];
        };
      };
    };
}
