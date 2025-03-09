host := `hostname`

# Rebuild and switch NixOS configuration
switch:
  nixos-rebuild switch --flake ~/devices#{{host}} --use-remote-sudo

# Initial system bootstrap using disko-install
disko-install NEWHOST DISK:
  sudo nix --experimental-features 'flakes nix-command' run 'github:nix-community/disko/latest#disko-install' -- --flake /home/nixos/devices#{{ NEWHOST }} --disk main {{ DISK }}

