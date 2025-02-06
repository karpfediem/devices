{inputs, ezModules, ...}: {
  imports = [
    ../nixos-modules/nixpkgs
    inputs.catppuccin.homeManagerModules.catppuccin
  ];
}
