{ config, pkgs, lib, ... }:

{
   systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder.
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
	       id = "OOE4SHN-62TR6B7-Y2LNEOD-Z3BEWN5-S32BA5N-LNTLYEJ-7D4VHF3-O6L7FQ7";
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
