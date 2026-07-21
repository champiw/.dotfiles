{ config, pkgs, lib, ... }:

let
  username = builtins.head (builtins.attrNames config.users.users);

  llamaPackage = pkgs.llama-cpp.override {
    cudaSupport = true;
  };

  profile = import ./profile.nix;
in
{
  environment.systemPackages = [
    llamaPackage

    # Alias commands
    (pkgs.writeShellScriptBin "llama-start" ''
      exec sudo systemctl start llama-cpp
    '')
    (pkgs.writeShellScriptBin "llama-stop" ''
      exec sudo systemctl stop llama-cpp
    '')
    (pkgs.writeShellScriptBin "llama-status" ''
      exec systemctl status llama-cpp
    '')
  ];

  services.llama-cpp = {
    enable = true;
    package = llamaPackage;

    settings = profile;
  };

  systemd.services.llama-cpp = { 
    # Don't start automatically at boot.
    wantedBy = lib.mkForce [ ];

    serviceConfig = {
	BindReadOnlyPaths = [
	    "/home/${username}/.models:/models"
	];
    };
  };
}
