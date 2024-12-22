{inputs, pkgs, osConfig, ...}: {
  imports = [ 
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  programs.plasma.catpuccin = {
    inherit (osConfig) flavor accent;
  };

  home.packages = with pkgs; [
    bibata-cursors
    (catppuccin-kde.override {
      inherit (osConfig) flavor accent;
    })
  ];
  
  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      iconTheme = "breeze-dark";
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 22;
      };
      clickItemTo = "open";
    };

    hotkeys.commands."launch-konsole" = {
      name = "Launch Terminal";
      key = "Meta+Return";
      command = "kitty";
    };
  };
}
