let
  pkgs = import <nixpkgs> { };
  flake =
    (import
      (fetchTarball {
        url = "https://github.com/edolstra/flake-compat/archive/v1.1.0.tar.gz";
        sha256 = "19d2z6xsvpxm184m41qrpi1bplilwipgnzv9jy17fgw421785q1m";
      })
      {
        src = ./.;
      }
    ).defaultNix;
  buildScript = flake.packages.${builtins.currentSystem}.build;
in
pkgs.stdenv.mkDerivation {
  name = "sallys-bakes-site";

  src = ./.;

  buildInputs = with pkgs; [
    buildScript
    jekyll
  ];

  buildPhase = ''
    # Create a temporary home directory where Jekyll can write cache files
    export HOME=$(mktemp -d)

    # Create a temporary directory for Jekyll cache
    mkdir -p $HOME/.jekyll-cache

    # Run the Jekyll build with explicit cache directory setting
    cd $src
    jekyll build --source $src --destination $PWD/_site --disable-disk-cache
  '';

  installPhase = ''
    # Copy the built site to the output directory
    mkdir -p $out
    cp -r _site/* $out/
  '';
}
