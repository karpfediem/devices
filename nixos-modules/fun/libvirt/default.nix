{pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  environment.systemPackages = with pkgs; [ virtiofsd ];
  programs.virt-manager.enable = true;

  # Enable TPM emulation (optional)
  virtualisation.libvirtd.qemu = {
    swtpm.enable = true;
    ovmf.packages = [ pkgs.OVMFFull.fd ];
  };

  # Enable USB redirection (optional)
  virtualisation.spiceUSBRedirection.enable = true;
}
