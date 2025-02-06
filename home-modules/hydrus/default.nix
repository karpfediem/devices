{pkgs, ...}: {
  home.packages = with pkgs; [
    hydrus
  ];
  xdg.desktopEntries = {
    hydrus = {
      name = "hydrus";
      genericName = "Hydrus";
      exec = "hydrus-client -d /mnt/media/hydrus/db";
      icon = "/usr/lib/hydrus/static/hydrus_non-transparent.png";
      terminal = false;
      type = "Application";
      categories = ["Application" "FileTools" "Graphics" "Network"];
    };
  };
}