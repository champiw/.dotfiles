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
    ../../modules/programs/qutebrowser.nix
    ../../modules/programs/nvim.nix
    ../../modules/programs/vscodium.nix
    ../../modules/programs/obsidian.nix
    ../../modules/programs/nautilus.nix
    ../../modules/programs/minecraft.nix

    ../../modules/programs/alacritty.nix

    # Desktop environment modules
    ../../modules/desktop/niri.nix
    ../../modules/desktop/noctalia.nix
   
    # Network storage mount
    ../../modules/network/network-storage.nix
    
    # Syncthing service
    ../../modules/services/syncthing-client.nix

    # Home manager
    inputs.home-manager.nixosModules.home-manager
  ];
  
  # Host config
  networking.hostName = "dopros";
  system.stateVersion = "25.11";

  # Activate bluetooth
  hardware.bluetooth.enable = true;

  # Fonts config
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];
  fonts.fontconfig.defaultFonts.monospace = [ "JetBrains Mono" ];

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
