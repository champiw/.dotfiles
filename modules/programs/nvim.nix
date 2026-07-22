{ pkgs, ... }:

{
   home-manager.users.champi = { config, ... }: {
      home.packages = with pkgs; [
        neovim
		#ripgrep
		#nil
		#nixpkgs-fmt
		#nodejs
		#gcc
      ];

      # Symlink nvim folder with lua config
      xdg.configFile."nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink 
		"${config.home.homeDirectory}/.dotfiles/modules/programs/nvim";
      };
   };
}
