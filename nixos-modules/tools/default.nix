{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    devenv
    jq
    yq-go
    ripgrep
    just
    libqalculate
    du-dust
    xclip
    wl-clipboard
  ];
}
