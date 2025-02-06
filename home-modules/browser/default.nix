{
  pkgs,
  inputs,
  fetchurl,
  ...
}: let
  custom-addons = import ./custom-addons {
    inherit (pkgs) lib stdenv fetchurl;
  };
in {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta;
#    package = inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin;
    profiles = {
      carp = {
        id = 0;
        isDefault = true;
        name = "carp";
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          umatrix
          privacy-badger
          i-dont-care-about-cookies
          cookie-quick-manager
          custom-addons.catppuccin-mocha-maroon
          custom-addons.save-selected-tabs-to-files
          bitwarden
          vimium
          simple-tab-groups
          unpaywall
          redirector
          dearrow
          return-youtube-dislikes
        ];
        search.engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
          "Nix Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "type";
                    value = "options";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@no"];
          };
          "NixOs Wiki" = {
            urls = [
              {
                template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
              }
            ];
            iconUpdateURL = "https://wiki.nixos.org/favicon.ico";
            updateInterval = 7 * 24 * 60 * 60 * 1000; # every week
            definedAliases = ["@nw"];
          };
          "Bing".metaData.hidden = true;
          "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
        };
        search.force = true;
        search.default = "Google";
        search.order = ["Google" "DuckDuckGo"];
        containersForce = true;
        containers = {
          default = {
            id = 1;
            name = "main";
            color = "toolbar";
            icon = "circle";
          };
          tech = {
            id = 2;
            name = "tech";
            color = "orange";
            icon = "circle";
          };
          chat = {
            id = 3;
            name = "chat";
            color = "purple";
            icon = "circle";
          };
          music = {
            id = 4;
            name = "music";
            color = "red";
            icon = "circle";
          };
          media = {
            id = 5;
            name = "media";
            color = "blue";
            icon = "circle";
          };
        };
      };
    };

    policies = {
      DisablePocket = true;
      PasswordManagerEnabled = false;
    };
  };
}
