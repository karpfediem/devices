{ config, inputs, lib, modulesPath, pkgs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t450s
    (modulesPath + "/installer/scan/not-detected.nix")
    ../disko/luks-lvm.nix
  ];
  
  disko.devices.disk.root.device = "/dev/sda";

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  swapDevices = lib.mkForce [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/79e630e2-199b-4a46-989e-7795d9300300";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/0C15-2455";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/14b98e5a-2027-4e36-bcb8-0a368d0e7361"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  nix.settings.max-jobs = 16;
  nix.extraOptions = ''
    build-cores = 20
  '';

  nixpkgs.hostPlatform = "x86_64-linux";


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
