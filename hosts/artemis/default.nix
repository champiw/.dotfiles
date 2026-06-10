{ config, pkgs, inputs, ... }:

{
  imports = [

    # System hardware modules
    ./hardware.nix
    ../../modules/hardware/laptop.nix
    ../../modules/hardware/pipewire.nix
    ../../modules/services/ssh.nix
    
    # Base modules
    ../../modules/base

    # Program modules
    ../../modules/programs/nvim.nix
    ../../modules/programs/alacritty.nix
    
    # Services
    ../../modules/services/samba.nix
    ../../modules/services/jellyfin.nix
    ../../modules/services/syncthing.nix

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
  ];

}
