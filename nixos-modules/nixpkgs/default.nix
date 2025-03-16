{lib, inputs, ...}:
let
 pinPackagesToVersion = nixpkgsInput: packageNames:
  final: prev:
  let
    pinned = import nixpkgsInput {
      system = final.system;
      inherit (prev) config;
    };
  in builtins.listToAttrs ( map ( name: { inherit name; value = pinned.${name}; } ) packageNames );
in {
  nixpkgs.overlays =
  [
    inputs.nur.overlays.default
    (import ./overlays/kitty)
    (pinPackagesToVersion inputs.nixpkgs-unstable [
      "devenv"
      "teller"
      "jujutsu"
      "hydrus"
    ])
  ];
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "steam-original"
    "steam-run"
    "vault-bin"
    "netdata"
    "nvidia-x11"
    "nvidia-settings"
    "jetbrains-toolbox"
    "rust-rover"
    "goland"
    "parsec-bin"
    "libqalculate"
  ];
}
