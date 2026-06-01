{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  /*
    Create the credentials file manually:
      sudo mkdir -p /etc/nixos/secrets
      sudo nvim /etc/nixos/secrets/storage-smb
    Contents:
      username=your_username
      password=your_samba_password
  */

  fileSystems."/storage" = {
    device = "//192.168.4.106/storage";
    fsType = "cifs";

    options = [
      "credentials=/etc/nixos/secrets/storage-smb"

      "uid=1000"
      "gid=100"

      "x-systemd.automount"

      "noauto"

      "nofail"
    ];
  };
}
