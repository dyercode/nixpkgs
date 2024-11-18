{
  stdenv,
  pkgs,
  ponyc,
  pony-corral,
}:
stdenv.mkDerivation {
  name = "pony-language-server";
  version = "0.2.2";

  src = pkgs.fetchFromGitHub {
    owner = "ponylang";
    repo = "pony-language-server";
    rev = "81135a7fb66d578549afdfb971b0cc8d07cca0a3";
    hash = "sha256-KGotqa4Y1xOWwGg64tfczSjPUcLOUj/eX5G1WONbjVk=";
    # fetchSubmodules = true;
  };

  nativeBuildInputs = [ ];
  buildInputs = [
    ponyc
    pony-corral
  ];

  buildPhase = ''
    make language_server
  '';

  installPhase = ''
    ls
    mkdir -p $out/bin
    cp language_server $out/bin/pony_language_server
  '';
}
