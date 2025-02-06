{pkgs, ...}: {
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    pam_u2f
    pamtester
  ];
}