{ pkgs, ... }:

{
  home-manager.users.champi = {
    home.packages = with pkgs; [
      osu-lazer-bin
    ];
  };

  # Tablet drivers
  hardware.opentabletdriver.enable = true;

  # Required by OpenTabletDriver
  hardware.uinput.enable = true;
  boot.kernelModules = [ "uinput" ];

}
