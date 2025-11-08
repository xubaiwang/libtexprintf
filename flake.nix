{
  description = "Flake utils demo";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        packages.default = pkgs.stdenv.mkDerivation {
      pname = "my-autogen-project";
      version = "1.0";

      src = ./.;

      # Add autoconf and automake to buildInputs if they are needed by autogen.sh
      buildInputs = [ pkgs.autoconf pkgs.automake pkgs.libtool ];

      # Run autogen.sh before the configure phase
      preConfigure = "./autogen.sh";

      # Add any necessary configure flags
      #configureFlags = [ "--enable-feature-a" ];

      # Optionally, specify an out-of-tree build if required
      # preConfigure = ''
      #   patchShebangs . ./autogen.sh
      #   mkdir build
      #   cd build
      # '';
      # configureScript = "../configure";
      # configureFlags = [ "--enable-feature-a" ];
    };
      }
    );
}
