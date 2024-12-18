#!/usr/bin/env bash
sudo nix --experimental-features 'flakes nix-command' run 'github:nix-community/disko/latest#disko-install' -- --flake /home/nixos/devices#calm-otter --disk main /dev/disk/by-id/ata-SAMSUNG_MZ7LN256HCHP-000L7_S20HNXAGA74260
