{ config, pkgs, ... }:

{
  imports =
  [
    ./hardware.nix
  ];

  networking.hostName = "dopros"; # Define your hostname.

  # Login display
  services.getty.autologinUser = "champi";
  
  # TODO: move?
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install steam
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
	  fastfetch
	  alacritty
	  fuzzel
	  xdg-utils
  ];

  environment.sessionVariables = {
    WLR_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";

    NIXOS_OZONE_WL = "1";
  };

  system.stateVersion = "25.11";
}
