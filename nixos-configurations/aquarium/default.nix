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
    ../../nixos-modules/fun/libvirt
    ../../nixos-modules/fun/vpn/mullvad
    ../../nixos-modules/fun/style/fonts.nix
    ../../nixos-modules/fun/games/steam
    ../../nixos-modules/fun/syncthing
    ../../nixos-modules/tools
    ../../nixos-modules/fun/ai
    ../../nixos-modules/infra/k3s
  ];

  systemd.services.nix-daemon.environment = {
    HF_TOKEN = "changeme";
    CIVITAI_API_TOKEN = "changeme";
  };

  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      git
      neovim
      btop
      vault-bin
      ;
  };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.extraConfig = {
      "monitor.bluez.properties" = {
        "bluez5.roles" = [ "a2dp_sink" "a2dp_source" "bap_sink" "bap_source" ];
      };
    };
  };

  services.pulseaudio = {
    package = pkgs.pulseaudioFull;
  };

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
      extraGroups = [ "wheel" "libvirtd" ];
    };
  };

  nix = {
    settings.trusted-users = [ "carp" ];
  };

  system.stateVersion = "24.11";
}
