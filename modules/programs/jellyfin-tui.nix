{ pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
      jellyfin-tui
   ];

   # Config file in ~/.config/jellyfin-tui/config.yaml
   #
   # Minumum config:
   # 
   # servers:
   # - name: Home Server
   # password: --password--
   # url: --server-url--
   # username: --username--
   # 
   # Optional config:
   # 
   # Grab from https://github.com/dhonus/jellyfin-tui until discord status part.
}
