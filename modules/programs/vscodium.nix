{ pkgs, ... }:

{
  home-manager.users.champi = {
    programs.vscodium = {
  enable = true;

  profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          vscodevim.vim
	  jdinhlife.gruvbox
          golang.go
          ms-python.python
	  jnoortheen.nix-ide
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
