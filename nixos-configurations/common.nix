{inputs, lib, ...} : {
  imports = [
    inputs.disko.nixosModules.disko
  ];

  allowUnfreePredicate = pkg: builtin.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "steam-original"
    "steam-run"
    "vault-bin"
    "parsec-bin"
  ];
}
