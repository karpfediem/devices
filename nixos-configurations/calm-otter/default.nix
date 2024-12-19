{ config, lib, modulesPath, pkgs, ... }:
{
  imports = [
    ../common.nix
    ../hardware/L450.nix
    ../../nixos-modules/kde
    ../../nixos-modules/steam
  ];

  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      git
      neovim
      kitty
      vault-bin
      parsec-bin
      ;
  };

  programs.firefox.enable = true;

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
    };
  };

  nix = {
    extraOptions = "experimental-features = nix-command flakes";

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = "24.11";
}
