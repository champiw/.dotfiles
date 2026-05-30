{ config, pkgs, inputs, ... }:

{
  imports = [

    # System hardware
    ./hardware.nix
    ../../modules/hardware/pipewire.nix
    ../../modules/hardware/nvidia-gpu.nix

    # Base modules
    ../../modules/base
    
    # Programs
    ../../modules/programs/vencord.nix
    ../../modules/programs/steam.nix
    ../../modules/programs/firefox.nix

    ../../modules/programs/alacritty.nix

    # Desktop environment modules
    ../../modules/desktop/niri.nix
   
    # Home manager
    inputs.home-manager.nixosModules.home-manager
  ];
  
  # Host config
  networking.hostName = "dopros";
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
