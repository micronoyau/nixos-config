with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "sublist3r";

  src = fetchgit {
    url = "https://github.com/aboul3la/Sublist3r";
    hash = "sha256-nrnb3jAIHw6WXR7VLNmi1YdfMBzHEIiMlGSbrvEi6Uc=";
    rev = "729d649ec5370730172bf6f5314aafd68c874124";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/sublist3r
    cp -r $src $out/sublist3r
  '';
}
