{
  description = "Library providing printf-style formatted output routines with tex-like syntax support.";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "libtexprintf";
          version = "1.25";

          src = ./.;

          buildInputs = with pkgs; [
            autoconf
            automake
            libtool
          ];

          preConfigure = "./autogen.sh";
        };
      }
    );
}
