{ pkgs, ... }:

{
    home-manager.users.champi = {
      home.packages = with pkgs; [
	vial
      ];
    };
}
