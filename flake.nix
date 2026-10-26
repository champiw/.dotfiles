{
  description = "Champi's nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs-qt";
    };
	
	nixpkgs-qt.url = "github:nixos/nixpkgs/2fcb964de67fcf60b43471c55d5d99e61a9ccb5a";

	lastbox.url = "github:champiw/lastbox";

  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: 
  {
    nixosConfigurations = {

      # Main desktop
      dopros = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs self; };
        modules = [
          ./hosts/dopros/default.nix
        ];
      };
      
      # Laptop server
      artemis = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs self; };
        modules = [
          ./hosts/artemis/default.nix
        ];
      };
    };
  };
}
