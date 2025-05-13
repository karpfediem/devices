{inputs, ezModules, ...}: {
  imports = [
    ../nixos-modules/nixpkgs
    inputs.catppuccin.homeModules.catppuccin
  ];
}
