{ inputs, ... }:
let
  lib = inputs.nixpkgs.lib;
  pinPackagesToVersion = nixpkgsInput: packageNames:
    final: prev:
      let
        pinned = import nixpkgsInput {
          system = final.system;
          inherit (prev) config;
        };
      in
      builtins.listToAttrs (map (name: { inherit name; value = pinned.${name}; }) packageNames);
in
[
  (pinPackagesToVersion inputs.nixpkgs-unstable [
    "devenv"
    "teller"
    "jujutsu"
    "libqalculate"
    "teamspeak6-client"
  ])
  (pinPackagesToVersion inputs.nixpkgs-2411 [
    "hydrus"
  ])
]
++ (import ./pkgs { inherit inputs; })
