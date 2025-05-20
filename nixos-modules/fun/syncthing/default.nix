{ ... }: {
  services = {
    syncthing = {
      enable = true;
      user = "carp";
      dataDir = "/home/carp/sync";
      configDir = "/home/carp/.config/syncthing";
      overrideDevices = true; # overrides any devices added or deleted through the WebUI
      overrideFolders = true; # overrides any folders added or deleted through the WebUI
      settings = {
        devices = {
          "aquarium" = { id = "TKUECVZ-TSQOLCX-J2LZDTZ-5DX437C-YKWXNRA-OUE7W2B-KRHRLIZ-NIXGTQH"; };
          "lenovo" = { id = "WV5JISA-3JRZPAJ-2R6Q5FW-E3GKQ4R-BRD64WU-Q303KGS-2U32V5W-TBXDUAE"; };
          "pixel" = { id = "LOAKNWI-YVR26SR-5D7MXX6-UFK5QZJ-4RQLF72-PE6HYRV-BAK6BNI-74RKUAE"; };
        };
        folders = {
          "sync" = {
            path = "/home/carp/sync";
            devices = [ "aquarium" "lenovo" "pixel" ];
            #ignorePerms = false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
          };
          "logs" = {
            path = "/home/carp/logs";
            devices = [ "aquarium" "lenovo" "pixel" ];
          };
        };
      };
    };
  };
}
