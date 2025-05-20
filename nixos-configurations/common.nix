{ inputs, pkgs, lib, ... }: {
  imports = [
    inputs.disko.nixosModules.disko
    inputs.catppuccin.nixosModules.catppuccin
  ];

  catppuccin = {
    enable = lib.mkDefault true;
    flavor = lib.mkDefault "mocha";
    accent = lib.mkDefault "maroon";
  };

  environment.systemPackages = with pkgs; [
    home-manager
    attic-client
  ];

  nix = {
    channel.enable = false;
    registry.unstable.flake = inputs.nixpkgs-unstable;

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://numtide.cachix.org"
        "https://devenv.cachix.org"
        "https://cache.karpfen.dev/sys"
        "https://ai.cachix.org"
        "https://cuda-maintainers.cachix.org"
      ];
      trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://numtide.cachix.org"
        "https://devenv.cachix.org"
        "https://cache.karpfen.dev/sys"
        "https://ai.cachix.org"
        "https://cuda-maintainers.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "sys:L5zpT+DS98U14F+agHzrWzc2KGDrCFdtpkR90YsQqt0="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
      ];
    };
  };

}
