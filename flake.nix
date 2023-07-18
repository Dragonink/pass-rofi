{
  description = "Pass extension that provides a UI using rofi";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages = rec {
        pass-rofi = import ./default.nix { inherit pkgs; };
        default = pass-rofi;
      };
    }
  );
}
