{
  description = "Mock support";

  inputs = {
    # Nixpkgs / NixOS version to use. Here using 22.11
    nixpkgs.url = "nixpkgs/nixos-23.11";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }:
    let supportedSystems = [ "x86_64-linux" ];
    in utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = (with pkgs; [
            nixpkgs-fmt
            maven
            openjdk11
          ]);

          shellHook = ''
            java --version
            export PROJECT_ROOT_DIR=$(pwd)
          '';
        };
      });

}
