{ config, pkgs, ... }:

{
	home-manager.users.champi = { config, pkgs, ... }: {
		home.packages = with pkgs; [
			neovim

			# LSPs
			nixd
			lua-language-server

			vscode-langservers-extracted
			tailwindcss-language-server
			svelte-language-server
			typescript
			typescript-language-server

			docker-language-server
			docker-compose-language-service

			# tools & dependencies
			ripgrep
			fd
			tree-sitter
			gcc
		];

		# Symlink nvim folder with lua config
		xdg.configFile."nvim" = {
			source = config.lib.file.mkOutOfStoreSymlink 
				"${config.home.homeDirectory}/.dotfiles/modules/programs/nvim";
		};
	};
}
