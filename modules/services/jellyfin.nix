{ config, pkgs, ... }:

{
   services.jellyfin = {
      enable = true;

      # default directory: /var/lib/jellyfin
      # default user: 'jellyfin'
   };

   # Allow neccesary ports
   networking.firewall = {
      allowedTCPPorts = [ 8096 8920 ];
   };

   users.users.jellyfin.extraGroups = [ "users" ];

   environment.systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
   ];
}
