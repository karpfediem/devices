{inputs, lib, ...} : {
  imports = [
    inputs.disko.nixosModules.disko
  ];

  config.nix.channel.enable = false;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "steam-original"
    "steam-run"
    "vault-bin"
    "parsec-bin"
  ];
}
