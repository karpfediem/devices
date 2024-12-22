{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.plasma.catppuccin;
  cursorCfg = config.catppuccin.pointerCursor;
  enable = cfg.enable && config.programs.plasma.enable;

  lib' = import "${inputs.catppuccin}/modules/lib" { inherit config lib pkgs; };

  darkModeSettings =
    if cfg.flavor == "latte" then
      {
        lookAndFeel = "org.kde.breeze.desktop";
        iconTheme = "breeze";
      }
    else
      {
        lookAndFeel = "org.kde.breezedark.desktop";
        iconTheme = "breeze-dark";
      };
in
{
  options.programs.plasma.catppuccin = lib'.mkCatppuccinOption { name = "Plasma"; accentSupport = true; };

  config = lib.mkIf enable {
    home.packages = with pkgs; [
      (catppuccin-kde.override {
        flavour = [ cfg.flavor ];
        accents = [ cfg.accent ];
      })
    ];

    programs.plasma.workspace = {
      theme = "default"; # Actually Catppuccin
      colorScheme = "Catppuccin${lib'.mkUpper cfg.flavor}${lib'.mkUpper cfg.accent}";
      cursor.theme = lib.mkIf cursorCfg.enable "Catppuccin-${lib'.mkUpper cursorCfg.flavor}-${lib'.mkUpper cursorCfg.accent}-Cursors";
      inherit (darkModeSettings) lookAndFeel iconTheme;
    };
  };
}
