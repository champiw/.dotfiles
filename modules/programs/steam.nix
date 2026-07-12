{pkgs, ...}: 

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  programs.gamescope.enable = true;
}
