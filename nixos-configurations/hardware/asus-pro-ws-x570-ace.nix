{
  config,
  lib,
  modulesPath,
  inputs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.asus-pro-ws-x570-ace
  ];

  swapDevices = lib.mkForce [ ];
  boot = {
    initrd = {
      availableKernelModules = ["nvme" "ehci_pci" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "vfat" "nls_ascii" "nls_cp437" "nls_iso8859-1" "usbhid"];
      kernelModules = ["dm-snapshot"];
      supportedFilesystems = ["vfat" "fat"];
      systemd.enable = true;
      luks.devices = {
          "nixos-crypt" = {
            device = "/dev/disk/by-uuid/81d4dc2c-fb76-41a4-9d31-84d68d874b14";
            preLVM = true;
          };
      };
    };
    kernelModules = ["kvm-amd" "amd-pstate"];
    kernelParams = ["initcall_blacklist=acpi_cpufreq_init" "amd_pstate=passive" "amd_pstate=active" "nvidia.NVreg_PreserveVideoMemoryAllocations=1"];

    extraModulePackages = [];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };


  fileSystems."/" = {
    device = "/dev/disk/by-uuid/89d3f54b-6854-4bd4-b132-7c8daa625b56";
    fsType = "ext4";
  };
  fileSystems."/mnt/media" = {
    device = "/dev/disk/by-uuid/E480399880397262";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000"];
  };


  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  networking.interfaces.enp6s0f1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.fstrim.enable = true;

  hardware.pulseaudio.enable = false;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.beta;
#    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
#      version = "565.77";
#      sha256_64bit = "sha256-CnqnQsRrzzTXZpgkAtF7PbH9s7wbiTRNcM0SPByzFHw=";
#      sha256_aarch64 = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
#      openSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
#      settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
#      persistencedSha256 = lib.fakeSha256;
#    };
  };

  hardware.nvidia-container-toolkit.enable = true;

  services.fwupd.enable = true;

  system.stateVersion = "24.11";
}
