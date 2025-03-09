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
    mkdir -p $TMPDIR/_site
  '';

  buildPhase = ''
    jekyll build --source $PWD --destination $TMPDIR/_site
  '';

  installPhase = ''
    mkdir -p $out
    cp -r $TMPDIR/_site/* $out/
  '';
}
