{ config, pkgs, inputs, ... }:

{
  imports = [
    # System hardware modules
    ./hardware.nix
    ../../modules/hardware/laptop.nix
    ../../modules/hardware/pipewire.nix
    
    # Base modules
    ../../modules/base

    # Program modules
    ../../modules/programs/discord.nix
    ../../modules/programs/steam.nix
    ../../modules/programs/firefox.nix

    ../../modules/programs/alacritty.nix
    
    # Desktop environment modules
    ../../modules/desktop/niri.nix
    
    # Home manager
    inputs.home-manager.nixosModules.home-manager
  ];

  # Host config
  networking.hostName = "artemis";
  system.stateVersion = "25.11";

  # Home manager config
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users.champi = {
      home.username = "champi";
      home.homeDirectory = "/home/champi";
      home.stateVersion = "25.11"; 
    };
  };

  # Host packages
  environment.systemPackages = with pkgs; [
    fastfetch
    xdg-utils
  ];

}
