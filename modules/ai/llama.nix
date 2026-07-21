{ pkgs, lib, ... }:

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
