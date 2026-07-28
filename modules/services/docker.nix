{ pkgs, ... }:

{
	virtualisation.docker.enable = true;

	environment.systemPackages = with pkgs; [
		docker-compose
		lazydocker
	];

	users.users.champi.extraGroups = [ "docker" ];
}
