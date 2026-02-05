{ inputs, config, ... }: {
	imports = [ inputs.zen-browser.homeModules.twilight ];

	programs.zen-browser.enable = true;

	programs.zen-browser.policies = {
		DisableAppUpdate = true;
		NoDefaultBookmarks = true;
		OfferToSaveLogins = false;
		SearchSuggestEnabled = true;
		TranslateEnabled = false;
		DontCheckDefaultBrowser = true;
		# PictureInPicture = true;
	};

	programs.zen-browser.profiles.default.extensions.packages = 
		with inputs.firefox-addons.packages.x86_64-linux; [
			bitwarden
			ublock-origin
		];

	programs.zen-browser.profiles.default = {
		containersForce = true;
		spacesForce = true;
		# pinsForce = true;
	};

	programs.zen-browser.profiles.default.settings = {
		"browser.aboutConfig.showWarning" = false;
		"zen.welcome-screen.seen" = true;
		"zen.urlbar.behavior" = "float";
	};

	programs.zen-browser.profiles.default.search = {
		force = true;
		default = "ddg";
	};

	programs.zen-browser.profiles.default.containers = {
		Personal = {
			color = "blue";
			icon = "fingerprint";
			id = 1;
		};
		Work = {
			color = "orange";
			icon = "briefcase";
			id = 2;
		};
	};

	programs.zen-browser.profiles.default.spaces = 
		let containers = config.programs.zen-browser.profiles.default.containers; in {
		
		Personal = {
			id = "e862d4d1-7ef5-4652-a62d-1e0bef2e62e1";
			container = containers.Personal.id;
			position = 1000;
		};
		Work = {
			id = "ff114db8-005c-4d2f-8e92-a0e6f164a00a";
			container = containers.Work.id;
			position = 2000;
		};
	};

	xdg.mimeApps = {
		enable = true;
		defaultApplications = {
			"text/html" = [ "zen.desktop" ];
			"x-scheme-handler/http" = [ "zen.desktop" ];
			"x-scheme-handler/https" = [ "zen.desktop" ];
			"x-scheme-handler/about" = [ "zen.desktop" ];
			"x-scheme-handler/unknown" = [ "zen.desktop" ];
		};
	};

	# programs.zen-browser.profiles.default.pins =
	# 	let workspaces = config.programs.zen-browser.profiles.default.spaces; in {
	#
	# 	"Nix Search" = {
	# 		id = "b22cdd42-a903-4779-8adb-6c5c46ec044e";
	# 		url = "https://search.nixos.org/packages?channel=unstable&";
	# 		workspace = workspaces.Personal.id;
	# 		isEssential = true;
	# 		position = 101;
	# 	};
	# };
}
