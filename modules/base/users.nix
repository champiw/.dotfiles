{ pkgs, ... }:

{
  users.users.champi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    # ssh public key
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILYCEIXpvEZs+fkVbmpT5bytWL1VlKNrP2KPCtSeDznA champi@dopros"
    ];
  };
}
