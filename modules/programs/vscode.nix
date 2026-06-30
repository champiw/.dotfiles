{ pkgs, ... }:

{
  home-manager.users.champi = {
    programs.vscode = {
      enable = true;

      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          vscodevim.vim
          jdinhlife.gruvbox
          golang.go
          ms-python.python
          jnoortheen.nix-ide
          pkief.material-icon-theme
          esbenp.prettier-vscode
          svelte.svelte-vscode
          bradlc.vscode-tailwindcss
          github.copilot
          github.copilot-chat
        ];

        userSettings = {
          "workbench.colorTheme" = "Gruvbox Dark Medium";
          "workbench.iconTheme" = "material-icon-theme";
          "workbench.sideBar.location" = "right";
          "editor.fontFamily" = "JetBrains Mono";
          "terminal.integrated.fontFamily" = "JetBrains Mono";
          "svelte.enable-ts-plugin" = true;

          "github.copilot.enable" = {
            "*" = true;
          };
        };
      };
    };
  };
}
