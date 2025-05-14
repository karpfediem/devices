{ config, lib, modulesPath, pkgs, ... }:
{
  imports = [
    ../common.nix
    ../hardware/framework16.nix
    ../hardware/fw-fans.nix
    ../../nixos-modules/fun/desktop/kde
    ../../nixos-modules/fun/games/steam
    ../../nixos-modules/fun/games/shadow
    ../../nixos-modules/fun/vpn/mullvad
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

  powerManagement.cpuFreqGovernor = "powersave";
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "coy-koi";
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
