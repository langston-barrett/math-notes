{ pkgs ? import ./pinned-pkgs.nix { } }:

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

  src = if lib.inNixShell then null else lib.sourceFilesBySuffices ./. [ ".tex" ];

  # https://github.com/NixOS/nixpkgs/issues/24485
  FONTCONFIG_FILE = makeFontsConf {
    fontDirectories = [
      lmodern noto-fonts
      latinmodern-math tex-gyre-pagella-math
    ];
  };

  installPhase = ''
    mkdir -p "$out"
    for file in *.pdf *.md; do
      echo "Copying ${file}..."
      cp "$file" "$out"
    done
  '';

  buildPhase = ''
    mkdir -p TMP && export TEXMFCACHE=$PWD/TMP
    for texfile in crypto.tex group-theory.tex; do
      lualatex "$texfile"
    done
  '';

  buildInputs = [
    # amsthm_to_anki
    noto-fonts                   # latex text font
    latinmodern-math             # latex math font
    tex-gyre-pagella-math        # latex math font
    (texlive.combine {
      inherit (texlive)
      # Core
      scheme-basic euenc fontspec luatex lualibs luaotfload # luatex-def
      # General
      enumitem etoolbox filehook float hyperref ucharcat
      # Math
      amsmath lualatex-math mathtools unicode-math
      # Graphics
      pgf tikz-cd relsize xcolor;
    })
  ];
}
