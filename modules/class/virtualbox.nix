{ ... }:

{
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };

  users.users.champi.extraGroups = [ "vboxusers" ];
}
