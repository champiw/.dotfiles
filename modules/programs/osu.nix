{ pkgs, ... }:

{
  home-manager.users.champi = {
    home.packages = with pkgs; [
      osu-lazer-bin
    ];
  };
}
