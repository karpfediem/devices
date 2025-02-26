{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

    xdg.desktopEntries = {
    ghostty = {
      name = "ghostty";
      genericName = "Ghostty";
      exec = "ghostty";
      icon = "com.mitchellh.ghostty";
      terminal = false;
      type = "Application";
      categories = [ "System" "TerminalEmulator" ];
      startupNotify = true;
    };
  };
}
