{ pkgs, ... }:

{
  programs.niri.enable = true;

  # Portals for screenshare
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    waybar
    mako
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
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri";
        user = "champi";
      };
    };
  };

}
