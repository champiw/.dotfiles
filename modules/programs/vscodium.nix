{ pkgs, ... }:

{
  home-manager.users.champi = {
    programs.vscodium = {
  enable = true;

  profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          vscodevim.vim
	  jdinhlife.gruvbox
        ];

        userSettings = {
          "workbench.colorTheme" = "Gruvbox Dark Medium";
          "editor.fontFamily" = "JetBrains Mono";
          "terminal.integrated.fontFamily" = "JetBrains Mono";
        };
      };
    };    
  };
}
