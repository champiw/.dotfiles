{ config, pkgs, ... }:

{
   services.samba = {
      enable = true;

      openFirewall = true;

      settings = {
         global = {
            workgroup = "WORKGROUP";
            security = "user";
            "map to guest" = "bad user";
         };

         storage = {
            path = "/storage";
 
            browseable = "yes";
            writeable = "yes";
            "read only" = "no";
            "valid users" = "champi";

            "guest ok" = "no";
            "create mask" = "0644";
            "directory mask" = "0755";
         };
      };
   };

   services.samba-wsdd = {
      enable = true;
      openFirewall = true;
   };
}
