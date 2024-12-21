{inputs, pkgs, ...}: {
  imports = [ 
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  home.packages = with pkgs; [
    bibata-cursors
  ];
  
  programs.plasma = {
    enable = true;
    
     workspace = {
      clickItemTo = "open"; # If you liked the click-to-open default from plasma 5
      lookAndFeel = "org.kde.breezedark.desktop";
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 22;
      };
      iconTheme = "Breeze-Dark";
    };
    hotkeys.commands."launch-konsole" = {
      name = "Launch Terminal";
      key = "Meta+Enter";
      command = "kitty";
    };
  };
}
