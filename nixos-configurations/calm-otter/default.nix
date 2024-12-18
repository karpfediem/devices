{ config, lib, modulesPath, pkgs, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./hardware/L450.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  swapDevices = [];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    kernelModules = [ "kvm-intel" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/0c0bc059-b437-4541-a5b7-40bf41a25bef";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/9890-6726";
      fsType = "vfat";
    };
  };

  powerManagement.cpuFreqGovernor = "powersave";
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    logind = {
      lidSwitchDocked = "ignore";
      lidSwitch = "ignore";
      lidSwitchExternalPower = "ignore";
    };
  };

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

  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      git
      neovim
      ;
  };

  system.stateVersion = "24.11";
}
