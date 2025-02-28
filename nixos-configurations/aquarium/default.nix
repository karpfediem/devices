{ config, lib, modulesPath, pkgs, ... }:
{
  imports = [
    ../common.nix
    ../hardware/asus-pro-ws-x570-ace.nix
    # ../../nixos-modules/core/auto-upgrades
    ../../nixos-modules/core/backup
    ../../nixos-modules/core/monitoring/netdata
    ../../nixos-modules/core/u2f
    ../../nixos-modules/fun/desktop/kde
    ../../nixos-modules/fun/vpn/mullvad
    ../../nixos-modules/fun/style/fonts.nix
    ../../nixos-modules/fun/games/steam
    ../../nixos-modules/fun/syncthing
    ../../nixos-modules/tools
  ];

  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      git
      neovim
      btop
      vault-bin
      ;
  };

  hardware.bluetooth.enable = true;
  #services.blueman.enable = true;

  powerManagement.cpuFreqGovernor = "ondemand";
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "aquarium";
    networkmanager.enable = true;
  };

  users.users = {
    carp = {
      isNormalUser = true;
      description = "fishy";
      extraGroups = [ "wheel" ];
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
