{ pkgs, ... }:

{
   environment.systemPackages = with pkgs; [ neovim ];

   # home manager config
   home-manager.users.champi = {
      
      programs.neovim = {
         enable = true;
	 defaultEditor = true;
	 viAlias = true;
         vimAlias = true;

	 withPython3 = false;
	 withRuby = false;
      };

   };
}
