{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./configuration.nix
    
    # Modulos base
    ../../modules/base
    
    ../../modules/hardware/laptop.nix
    ../../modules/hardware/pipewire.nix
    ../../modules/desktop/niri.nix
    ../../modules/programs/discord.nix
  ];
}
