{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nautilus
    loupe
    vlc
  ];
}
