{
  pkgs ? import <nixpkgs> { },
}:

pkgs.stdenv.mkDerivation {
  name = "sallys-bakes-site";

  src = builtins.filterSource (
    path: type:
    !(builtins.elem (baseNameOf path) [
      ".git"
      ".jekyll-cache"
      "_site"
      "bin"
      "flake.lock"
      "flake.nix"
    ])
  ) ./.;

  nativeBuildInputs = with pkgs; [
    jekyll
  ];

  configurePhase = ''
    export HOME=$TMPDIR

    # Create necessary directories in the temporary writable location
    mkdir -p $TMPDIR/_site
  '';

  buildPhase = ''
    echo 'Building site'

    # Run Jekyll build with destination in the temporary directory
    jekyll build --source $PWD --destination $TMPDIR/_site
  '';

  installPhase = ''
    # Copy the built site to the output directory
    mkdir -p $out
    cp -r $TMPDIR/_site/* $out/
  '';
}
