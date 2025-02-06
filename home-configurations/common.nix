{inputs, lib, ...}: {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "parsec-bin"
  ];
}
