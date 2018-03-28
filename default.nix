{ pkgs ? import <nixpkgs> { } }:

# let
  # amsthm_to_anki = with pkgs; stdenv.mkDerivation {
  #   name = "amsthm-to-anki"
  #   version = "0.1.0";
  #   src = fetchFromGitHub {
  #     owner = "siddharthist";
  #     repo = "amsthm-to-anki";
  #     rev = "80a65d70a69c802eef9a86855c406ea1ed575427";
  #     sha256 = "1mg5fwfm2690ci7yhx7b84gqm2gynkfm8s13ipglsnbzqvxqd54p";
  #   }

  #   buildInputs = [
  #     gcc
  #     git
  #     gmp
  #     haskellPackages.stack
  #   ];

  #   buildPhase =
  # }
# in
with pkgs; stdenv.mkDerivation {
  name = "math-notes";
  version = "0.1.0";

  src = if lib.inNixShell then null else ./.;

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  buildPhase = ''
    for texfile in crypto.tex group-theory.tex; do
      latexmk -lualatex "$texfile"
    done
  '';

  installPhase = ''
    mkdir -p "$out"
    cp *.pdf $out
  '';

  buildInputs = [
    # amsthm_to_anki
    noto-fonts
    texlive.combined.scheme-full # lualatex, etc.
  ];
}
