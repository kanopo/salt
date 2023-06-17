{
  description = "Dmitri laptop Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
	config-allowUnfree = true;
      };
      user = "dmo";
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        laptop = lib.nixosSystem {
	  inherit system;
	  modules = [
	    ./configuration.nix
	    home-manager.nixosModules.home-manager {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	      home-manager.users.${user} = {
	        imports = [
	          ./homeManager/home.nix
	        ];
	      };
	    }
	  ];
	};
      };
    };
}

