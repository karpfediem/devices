{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    restic
    libnotify
  ];
  users.users.restic = {
    isNormalUser = true;
  };

  security.wrappers.restic = {
    source = "${pkgs.restic.out}/bin/restic";
    owner = "restic";
    group = "users";
    permissions = "u=rwx,g=,o=";
    capabilities = "cap_dac_read_search=+ep";
  };

  services.restic.backups = {
    home = {
      paths = [
        "/home"
      ];
      exclude = [
        "/home/*/.cache"
        "/home/*/code"
        "/home/*/.local/share/docker"
        "/home/*/.local/share/Steam"
      ];
      initialize = true;
      passwordFile = "/etc/nixos/secrets/restic-password";
      environmentFile = "/etc/nixos/secrets/restic-env";
      repository = "s3:https://objectstore.fra1.civo.com/backup";

      timerConfig = {
        OnCalendar = "00:05";
        RandomizedDelaySec = "5h";
      };

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
        "--keep-yearly 75"
      ];
    };
  };

  # Notification services for all backups above
  systemd.services = let
    backups = {
      home = {};
    };
  in
    pkgs.lib.mkMerge [
      (pkgs.lib.attrsets.mapAttrs'
        (
          backupName: _value:
            pkgs.lib.attrsets.nameValuePair ("restic-backups-" + backupName)
            {unitConfig.OnFailure = "notify-backup-${backupName}-failed.service";}
        )
        backups)
      (pkgs.lib.attrsets.mapAttrs'
        (
          backupName: _value:
            pkgs.lib.attrsets.nameValuePair ("notify-backup-" + backupName + "-failed")
            {
              enable = true;
              description = "Notify on failed backup";
              serviceConfig = {
                Type = "oneshot";
                User = "carp";
              };

              # required for notify-send
              environment.DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";

              script = ''
                ${pkgs.libnotify}/bin/notify-send --urgency=critical \
                  "Backup ${backupName} failed" \
                  "$(journalctl -u restic-backups-${backupName} -n 5 -o cat)"
              '';
            }
        )
        backups)
    ];
}
