{pkgs, lib, ...}: {
  services.signald = {
    enable = true;
    user = lib.mkDefault "carp";
  };

  environment.systemPackages = [ pkgs.signaldctl ];
}