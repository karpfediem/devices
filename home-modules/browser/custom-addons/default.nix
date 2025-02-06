{ fetchurl, lib, stdenv }@args:
let
  buildFirefoxXpiAddon = lib.makeOverridable ({ stdenv ? args.stdenv
    , fetchurl ? args.fetchurl, pname, version, addonId, url, sha256, meta, ...
    }:
    stdenv.mkDerivation {
      name = "${pname}-${version}";

      inherit meta;

      src = fetchurl { inherit url sha256; };

      preferLocalBuild = true;
      allowSubstitutes = true;

      passthru = { inherit addonId; };

      buildCommand = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -v -m644 "$src" "$dst/${addonId}.xpi"
      '';
  });

  packages = {
    "catppuccin-mocha-maroon" = buildFirefoxXpiAddon {
      pname = "catppuccin-mocha-maroon";
      version = "2.0";
      addonId = "{631a469d-9ed1-4f88-a4e4-ac985479c00f}";
      url = "https://addons.mozilla.org/firefox/downloads/file/3954871/catppuccin_mocha_maroon-2.0.xpi";
      sha256 = "86158a864d5fb39b5cac7b500ee1082b8f33464a1bb0101d577d8b006203aea3";
      meta = with lib;
      {
        homepage = "https://github.com/catppuccin/catppuccin";
        description = "Firefox theme based on https://github.com/catppuccin/catppuccin";
        license = licenses.mit;
        mozPermissions = [
        ];
        platforms = platforms.all;
      };
    };
    "save-selected-tabs-to-files" = buildFirefoxXpiAddon {
      pname = "save-selected-tabs-to-files";
      version = "1.2.0";
      addonId = "save-selected-tabs-to-files@piro.sakura.ne.jp";
      url = "https://addons.mozilla.org/firefox/downloads/file/4001417/save_selected_tabs_to_files-1.2.0.xpi";
      sha256 = "b2d80266fce6760e140be016e65bf8818fcdcaddd397c2401409d2395e9267a0";
      meta = with lib;
      {
        description = "Provides ability to save selected tabs to local files.";
        license = licenses.gpl2;
        mozPermissions = [
          "activeTab"
          "downloads"
          "menus"
          "notifications"
          "storage"
          "tabs"
        ];
        platforms = platforms.all;
      };
    };
  }; in packages