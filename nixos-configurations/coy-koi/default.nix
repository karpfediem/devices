{ config, lib, modulesPath, pkgs, ... }:
{
  imports = [
    ../common.nix
    ../hardware/framework16.nix
    ../../nixos-modules/kde
    ../../nixos-modules/steam
    ../../nixos-modules/shadow
  ];

  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      git
      neovim
      kitty
      vault-bin
      parsec-bin
      btop
      ;
  };

  hardware.bluetooth.enable = true;
  #services.blueman.enable = true;

  programs.firefox.enable = true;

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
