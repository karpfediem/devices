{ inputs, ... }: {
  imports = [
    ../nixos-modules/nixpkgs
    inputs.catppuccin.homeModules.catppuccin
  ];
}
