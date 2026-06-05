{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nautilus
    ffmpegthumbnailer
    loupe
    vlc
  ];
}
