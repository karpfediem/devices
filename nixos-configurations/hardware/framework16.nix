{ config, inputs, lib, modulesPath, pkgs, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
    ./disko
  ];
  
  disko.devices.disk.main.device = "/dev/disk/by-id/nvme-Samsung_SSD_990_PRO_4TB_S7DPNF0XB26296A";

  swapDevices = lib.mkForce [ ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "usbhid" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # VAAPI
  hardware.graphics.enable = true;

  # firmware updates
  services.fwupd.enable = true;

  system.stateVersion = "24.11";
}
