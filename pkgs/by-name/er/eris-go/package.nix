{ lib, stdenv, buildGoModule, fetchFromGitea, mandoc, tup, nixosTests }:

buildGoModule rec {
  pname = "eris-go";
  version = "20240128";
  outputs = [ "out" "man" ];

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "eris";
    repo = "eris-go";
    rev = version;
    hash = "sha256-mS5PMrp6rBR8ehlpDAZaTQL8vhFSpcztMaQF5zjozxc=";
  };

  vendorHash = "sha256-pA/fz7JpDwdTRFfLDY0M6p9TeBOK68byhy/0Cw53p4M=";

  nativeBuildInputs = [ mandoc tup ];

  postConfigure = ''
    rm -f *.md
    tupConfigure
  '';
  postBuild = "tupBuild";
  postInstall = ''
    install -D *.1.gz -t $man/share/man/man1
  '';

  env.skipNetworkTests = true;

  passthru.tests = { inherit (nixosTests) eris-server; };

  meta = src.meta // {
    description = "Implementation of ERIS for Go";
    homepage = "https://codeberg.org/eris/eris-go";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ ehmry ];
    broken = stdenv.isDarwin;
    mainProgram = "eris-go";
  };
}
