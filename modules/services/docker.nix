{ pkgs, ... }:

{
	virtualisation.docker.enable = true;

	# Enable NVIDIA GPU passthrough for Docker containers
	hardware.nvidia-container-toolkit.enable = true;

	environment.systemPackages = with pkgs; [
		docker-compose
		lazydocker
	];

	users.users.champi.extraGroups = [ "docker" ];
}
