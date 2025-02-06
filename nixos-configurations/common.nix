{inputs, pkgs, lib, ezModules, ...} : {
  imports = [
    inputs.disko.nixosModules.disko
    inputs.catppuccin.nixosModules.catppuccin
    ezModules.nixpkgs
  ];

  catppuccin = {
    enable = lib.mkDefault true;
    flavor = lib.mkDefault "mocha";
    accent = lib.mkDefault "maroon";
  };

  environment.systemPackages = [
    pkgs.home-manager
  ];
  nix.channel.enable = false;
}
