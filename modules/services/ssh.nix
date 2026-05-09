{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false; 
      PermitRootLogin = "no";
    };
  };

  # Open default port
  networking.firewall.allowedTCPPorts = [ 22 ];
}
