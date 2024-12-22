{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      kitty = prev.kitty.overrideAttrs (o: {
        postInstall =
          (o.postInstall or "")
          + ''
            cp -f ${./kitty.app.png} $out/share/icons/hicolor/256x256/apps/kitty.png
            rm -f $out/share/icons/hicolor/scalable/apps/kitty.svg
          '';
      });
    })
  ];

  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    extraConfig = ''
      keybindings = {
        # Keyboard mappings
        "shift+page_up" = "scroll_page_up";
        "shift+page_down" = "scroll_page_down";
        "ctrl+shift+." = "change_font_size all -2.0";
        "ctrl+shift+," = "change_font_size all +2.0";
      };
      scrollback_pager nvim -u NONE -c "set nonumber nolist showtabline=0 foldcolumn=0 laststatus=0" -c "autocmd TermOpen * normal G" -c "silent write! /tmp/kitty_scrollback_buffer | te head -c-1 /tmp/kitty_scrollback_buffer; rm /tmp/kitty_scrollback_buffer; cat"
    '';
  };

  xdg.configFile."kitty/kitty.app.png" = { source = ./kitty.app.png; recursive = true;};
}
