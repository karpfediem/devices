{inputs, pkgs, osConfig, config, ...}:
let
  ctp = osConfig.catppuccin or config.catppuccin or {flavor = "mocha"; accent = "maroon";};
in
{
  imports = [ 
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ./catppuccin.nix
  ];


  home.packages = with pkgs; [
    bibata-cursors
  ];
  
  programs.plasma = {
    enable = true;

    catppuccin = {
      flavor = ctp.flavor;
      accent = ctp.accent;
    };
    workspace = {
      clickItemTo = "open";
    };

    hotkeys.commands."launch-konsole" = {
      name = "Launch Terminal";
      key = "Meta+Return";
      command = "kitty";
    };
  };
}
