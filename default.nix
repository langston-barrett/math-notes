{ pkgs ? import <nixpkgs> { } }:

with pkgs; stdenv.mkDerivation rec {
  name = "math-notes";
  version = "0.1.0";

  src = if lib.inNixShell then null else ./.;

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  buildPhase = ''
    for texfile in *.tex; do
      latexmk -lualatex "$texfile"
    done
  '';

  installPhase = ''
    cp *.pdf $out
  '';

  buildInputs = [
    noto-fonts
    texlive.combined.scheme-full # lualatex, etc.
  ];
}
