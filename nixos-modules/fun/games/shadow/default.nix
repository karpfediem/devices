{ pkgs, ... }: {

  environment.systemPackages = [
    (pkgs.appimageTools.wrapType2 {
      pname = "shadow-tech";
      version = "0.1.0";
      src = pkgs.fetchurl {
        url = "https://update.shadow.tech/launcher/prod/linux/ubuntu_18.04/ShadowPC.AppImage";
        hash = "sha256-0jGv+1Slj4smRvPw6dc7+SAq0BQmc7NYMXztkR5/0nU=";
      };
      extraPkgs = pkgs: with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        libdrm
        libva
        libva1
        libva-utils
        libinput
        xorg.libXau
        xorg.libXdmcp
      ];
    })
  ];
}
