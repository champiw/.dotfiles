{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vagrant
    gnupg
    lsb-release
    gnumake
    binutils
    pkg-config
  ];
}
