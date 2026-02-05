{
  description = "Home Manager configuration of utlight";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
    	url = "github:0xc000022070/zen-browser-flake/1.18t-1760588128";
	inputs.nixpkgs.follows = "nixpkgs";
	inputs.home-manager.follows = "home-manager";
    };
    firefox-addons = {
    	url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
	inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = inputs: {
      homeConfigurations."utlight" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

        modules = [ ./home.nix ];

	extraSpecialArgs = { inherit inputs; };
      };
    };
}
