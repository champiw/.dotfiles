{ pkgs, ... }:

{
  programs.niri.enable = true;

  # Portals for screenshare
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config = {
      common = { 
        default = [ "gtk" "gnome" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
        "org.freedesktop.impl.portal.ScreenShot" = [ "gnome" ];
      };
    };
  };

  services.dbus.enable = true;
  programs.dconf.enable = true;

  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    waybar
    mako
    pavucontrol
    wl-clipboard
  ];

  programs.xwayland.enable = true;

  services.displayManager.sessionPackages = [ pkgs.niri ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_DESKTOP = "niri";
    GSK_RENDERER = "ngl";
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri";
        user = "champi";
      };
    };
  };

}
