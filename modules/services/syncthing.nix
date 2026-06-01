{ config, pkgs, lib, ... }:

{
   systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Dont create default ~/Sync folder

   services.syncthing = {
      enable = true;
      openDefaultPorts = true; 

      user = "champi";
      group = "users";
      configDir = "/home/champi/.config/syncthing";

      # Override gui settings
      overrideDevices = true;
      overrideFolders = true;

      settings = {
         devices = {
	    "dopros" = {
	       id = "PW232GW-AYIBQBM-2NLTMNZ-O7U3HEK-KJYWNSA-5SAFGAP-G3WZ3FR-GFUSLQS";
	    };
	    
	    "nothing" = {
	       id = "2G6GXCH-FM2L3MV-YWLDPEX-OUCEO5L-NYG4UCY-5ZX22QR-437KROZ-XYFG5QS";
	    };
	 };

	 folders = {
	    "obsidian-vault" = {
	       path = "/storage/obsidian/obsidian-vault";

	       devices = [
	          "dopros"
		  "nothing"
	       ];

	       ignorePerms = true;

	       versioning = {
	          type = "simple";
		  params = {
		     keep = "10";
		  };
	       };

	    };
	 };
      };
   };
}
