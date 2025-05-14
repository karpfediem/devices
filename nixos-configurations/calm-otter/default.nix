{ config, lib, modulesPath, pkgs, ... }:
{
  imports = [
    ../common.nix
    ../hardware/L450.nix
    ../../nixos-modules/fun/desktop/kde
    ../../nixos-modules/fun/games/steam
    ../../nixos-modules/fun/games/shadow
  ];

  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      git
      neovim
      btop
      vault-bin
      ;
  };

  powerManagement.cpuFreqGovernor = "powersave";
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "calm-otter";
    networkmanager.enable = true;
  };

  users.users = {
    carp = {
      isNormalUser = true;
      description = "fishy";
      extraGroups = [ "wheel" ];
    };
  };

  system.stateVersion = "24.11";
}
