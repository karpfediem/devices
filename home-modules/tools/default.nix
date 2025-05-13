{pkgs, ...}: {

  home.packages = with pkgs; [
    mpv
    libqalculate
    busybox
  ];
}
