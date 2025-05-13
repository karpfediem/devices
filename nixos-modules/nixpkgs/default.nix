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
      "libqalculate"
      "teamspeak6-client"
    ])
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    # Steam
    "steam"
    "steam-unwrapped"
    "steam-original"
    "steam-run"
    # nvidia drivers
    "nvidia-x11"
    "nvidia-settings"
    # Tools
    "vault-bin"
    "netdata"
    "jetbrains-toolbox"
    "rust-rover"
    "goland"
    "parsec-bin"
  ];
}
