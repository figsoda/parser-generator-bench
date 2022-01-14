{ stdenv, antlr, jdk, makeWrapper, jre }:

stdenv.mkDerivation rec {
  pname = "calc-antlr-java";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [ antlr jdk makeWrapper ];

  postInstall = ''
    mkdir $out/bin
    makeWrapper ${jre}/bin/java $out/bin/${pname} \
      --add-flags "-cp $out/share:${antlr.jarLocation} Main"
  '';
}
