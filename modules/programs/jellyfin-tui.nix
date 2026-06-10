{ pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
      jellyfin-tui
   ];
}
