{ inputs, ... }: {
	imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

	services.flatpak.enable = true;
	services.flatpak.overrides.global.Context.sockets = [ "wayland" ];
	services.flatpak.packages = [
		"com.valvesoftware.Steam"
		"com.github.IsmaelMartinez.teams_for_linux"
		"com.discordapp.Discord"
	];
}
