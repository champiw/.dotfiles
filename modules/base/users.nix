{ pkgs, ... }:

{
  users.users.champi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    # ssh public key
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF6vYq0TGlo3PZz3GnQxNLwq2mLAu+J8eL+kLInx9rRC desktop"
    ];
  };
}
