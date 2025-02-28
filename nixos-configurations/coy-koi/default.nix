{ config, lib, modulesPath, pkgs, ... }:
{
  imports = [
    ../common.nix
    ../hardware/framework16.nix
    ../../nixos-modules/fun/desktop/kde
    ../../nixos-modules/fun/games/steam
    ../../nixos-modules/fun/games/shadow
    ../../nixos-modules/fun/vpn/mullvad
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
