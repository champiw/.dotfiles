{ config, pkgs, lib, ... }:

{
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Dont create default ~/Sync folder

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;

    user = "champi";
    group = "users";
    configDir = "/home/champi/.config/syncthing";

    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices = {
        "artemis" = {
          id = "7YTROWC-ILSH2E5-M6AXUH6-TPPUQQP-VE2YKEC-BNZBJV2-B6EYAY7-5OFW7AV";
        };
      };

      folders = {
        "obsidian-vault" = {
          path = "/home/champi/Documents/obsidian-vault";
          devices = [ "artemis" ];
          ignorePerms = true;
        };
      };
    };
  };
}
