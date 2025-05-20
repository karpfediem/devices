{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-2411.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      url = "github:nix-community/home-manager/release-25.05";
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
      url = "github:nix-community/nixvim/nixos-25.05";
    };
    nixified-ai = {
      url = "github:nixified-ai/flake";
    };

    fw-fanctrl = {
      url = "github:TamtamHero/fw-fanctrl/packaging/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ flake-parts, system-manager, nixidy, ... }:
    let
      overlays = import ./overlays { inherit inputs; };
      pkgsConfig = { };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.git-hooks-nix.flakeModule
        inputs.ez-configs.flakeModule
      ];

      systems = [ "x86_64-linux" ];

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

      perSystem = { config, self', inputs', system, ... }:
        let
          pkgs = import inputs.nixpkgs {
            inherit system overlays;
            config = pkgsConfig;
          };
        in
        {
          _module.args = { inherit pkgs; };

          devShells.default = pkgs.mkShell {
            name = "devices";
            shellHook = ''
              ${config.pre-commit.installationScript}
              echo 1>&2 "Welcome to the development shell!"
            '';
          };

        pre-commit = {
          check.enable = true;
          settings.hooks = {
            nixpkgs-fmt.enable = true;
          };
        };
      };
    };
}
