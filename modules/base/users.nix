{ pkgs, ... }:

{
  users.users.champi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
  };
}
