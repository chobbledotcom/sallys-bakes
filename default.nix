let
  pkgs = import <nixpkgs> { };
  flake =
    (import
      (fetchTarball {
        url = "https://github.com/edolstra/flake-compat/archive/99f1c2157fba4bfe6211a321fd0ee43199025dbf.tar.gz";
        sha256 = "0x2jn3vrawwv9xp15674wjz9pixwjyj3j771izayl962zziivbx2";
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
    # Ensure we're in the source directory
    cd $src

    # Run the Jekyll build
    ${buildScript}/bin/build
  '';

  installPhase = ''
    # Copy the built site to the output directory
    mkdir -p $out
    cp -r _site/* $out/
  '';
}
