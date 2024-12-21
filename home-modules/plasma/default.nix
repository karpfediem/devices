{inputs, ...}: {
  imports = [ 
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  
  programs.plasma = {
    enable = true;
    
     workspace = {
      clickItemTo = "open"; # If you liked the click-to-open default from plasma 5
      lookAndFeel = "org.kde.breezedark.desktop";
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 32;
      };
      iconTheme = "Papirus-Dark";
    };
    hotkeys.commands."launch-konsole" = {
      name = "Launch Terminal";
      key = "Meta+Enter";
      command = "kitty";
    };
  };
}
