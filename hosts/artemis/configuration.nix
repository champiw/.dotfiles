{ config, pkgs, ... }:

{
  imports =
  [
    ./hardware.nix
  ];

  networking.hostName = "artemis"; # Define your hostname.
  
  # TODO: move?
  # Install firefox.
  programs.firefox.enable = true;

  # Install steam
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
	  fastfetch
	  alacritty
	  fuzzel
	  xdg-utils
  ];

  system.stateVersion = "25.11";
}
