{ inputs, ... }:

{
  imports = [ inputs.lastbox.nixosModules.default ];

  services.lastbox = {
    enable = true;
    directory = "/srv/lastbox";
    port = 8010;
    openFirewall = true;
  };
}
