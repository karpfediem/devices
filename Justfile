host := `hostname`
username := `whoami`

# Rebuild and switch NixOS configuration
switch:
  nixos-rebuild switch --flake ~/devices#{{host}} --use-remote-sudo

# Rebuild and switch Home-Manager configuration
home:
  home-manager switch --flake ~/devices#{{username}}@{{host}}

# Initial system bootstrap using disko-install
disko-install NEWHOST DISK:
  sudo nix --experimental-features 'flakes nix-command' run 'github:nix-community/disko/latest#disko-install' -- --flake .#{{ NEWHOST }} --disk main {{ DISK }}

