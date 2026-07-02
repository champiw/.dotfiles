{ pkgs, ... }:

{
  home-manager.users.champi = {
    home.packages = with pkgs; [
      vial
    ];
  };

  hardware.keyboard.qmk.enable = true;

  services.udev.packages = with pkgs; [ qmk-udev-rules ];

  users.users.champi.extraGroups = [
    "input"
    "uinput"
  ];
}
