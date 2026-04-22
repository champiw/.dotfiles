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
      niri = { 
        default = [ "gnome" "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
  };
  

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    waybar
    mako
    fuzzel
    pavucontrol
    wl-clipboard
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "champi";
      };
    };
  };

}
