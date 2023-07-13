{
	description = "Pass extension that provides a UI using rofi";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
		let
			pkgs = nixpkgs.legacyPackages.${system};
		in rec {
			packages = rec {
				pass-rofi = pkgs.callPackage ./default.nix {};
				default = pass-rofi;
			};
			legacyPackages = packages;
			apps = rec {
				pass-rofi = flake-utils.lib.mkApp { drv = self.packages.${system}.pass-rofi; };
				default = pass-rofi;
			};
		}
	);
}
