{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nautilus
    ffmpegthumbnailer
    loupe
    vlc
    losslesscut
  ];

  # Auto detect usb and external drives
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Set dark mode
  home-manager.users.champi = {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

}
