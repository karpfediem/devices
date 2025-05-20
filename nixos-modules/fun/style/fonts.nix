{ pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      twemoji-color-font
      crimson
      comfortaa
      dejavu_fonts
      font-awesome
      inconsolata # monospaced
      noto-fonts-emoji
      noto-fonts-extra
      powerline-fonts
    ];
  };
}
