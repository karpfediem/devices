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
      iconTheme = "breeze-dark";
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 22;
      };
    };
    hotkeys.commands."launch-konsole" = {
      name = "Launch Terminal";
      key = "Meta+Return";
      command = "kitty";
    };
  };
}
