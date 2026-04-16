{ pkgs, ... }:

{
  programs.niri.enable = true;

  # Portals for screenshare
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config = {
      common = { 
        default = [ "gnome" "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
      };
    };
  };

  services.dbus.enable = true;
  programs.dconf.enable = true;

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
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_DESKTOP = "niri";
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
