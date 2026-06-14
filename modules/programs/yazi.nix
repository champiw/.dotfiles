{ pkgs, ... }:

{
   environment.systemPackages = with pkgs; [ yazi ];

   # home manager config
   home-manager.users.champi = {
      programs.yazi = {
         enable = true;

	 settings = {
	    manager = {
	       show_hidden = true;
	       show_symlink = true;
	       sort_by = "natural";
	       sort_reverse = false;
	       sort_dir_first = true;
	       linemode = "size";
	    };

	    preview = {
               wrap = "yes";
               image_filter = "lanczos3";
               image_quality = 90;
            };

	    opener = {
               edit = [
                  { run = "nvim \"$@\""; block = true; }
	       ];
            };

	    theme = {
	       flavor = "dark";
	    };
	 };

	 keymap = {
	    mgr = {
	       prepend_keymap = [
	          {
		     on = [ "g" "h" ];
		     run = "cd ~";
		     desc = "Home";
		  }
		  {
		     on = [ "g" "p" ];
		     run = "cd ~/Projects";
		     desc = "Projects";
		  }
		  {
		     on = [ "g" "w" ];
		     run = "cd ~/work";
		     desc = "Work";
		  }
		  {
		     on = [ "g" "i" ];
		     run = "cd ~/Pictures/fotos";
		     desc = "Photos";
		  }
	       ];
	    };
	 };
      };
   };
}
