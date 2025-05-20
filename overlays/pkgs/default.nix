{ inputs, ... }:
let
  lib = inputs.nixpkgs.lib;

  dirs = let all = builtins.readDir ./.; in (lib.filter (n: all.${n} == "directory")) (lib.attrNames all);

  grabOverlayFunction = name:
    let
      path = ./. + "/${name}";
    in
    # only import if it has a default.nix
    if builtins.pathExists "${path}/default.nix" && (builtins.readFile "${path}/default.nix") != ""
    then (import path)
    else lib.trace "[overlays] skipping ${name}, no default.nix" null;

  overlays = map grabOverlayFunction dirs;
in
lib.filter (o: o != null) overlays
