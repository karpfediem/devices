{inputs, lib, ...} : {
  imports = [
    inputs.disko.nixosModules.disko
    inputs.catppuccin.nixosModules.catppuccin
  ];

  catppuccin.enable = lib.mkDefault true;
  catppuccin.flavor = lib.mkDefault "mocha";

  nix.channel.enable = false;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "steam-original"
    "steam-run"
    "vault-bin"
    "parsec-bin"
  ];

}
