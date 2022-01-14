{ stdenv, antlr, graalvm17-ce, jdk, makeWrapper, jre }:

{
  graal = stdenv.mkDerivation rec {
    pname = "calc-antlr-java-graal";
    version = "0.1.0";

    src = ./.;

    nativeBuildInputs = [ antlr graalvm17-ce ];

    postBuild = ''
      native-image Main ${pname} -cp .:${antlr.jarLocation}
    '';

    installPhase = ''
      runHook preInstall
      install -Dm755 ${pname} -t $out/bin
      runHook postInstall
    '';
  };

  openjdk = stdenv.mkDerivation rec {
    pname = "calc-antlr-java-openjdk";
    version = "0.1.0";

    src = ./.;

    nativeBuildInputs = [ antlr jdk makeWrapper ];

    postInstall = ''
      mkdir $out/bin
      makeWrapper ${jre}/bin/java $out/bin/${pname} \
        --add-flags "-cp $out/share:${antlr.jarLocation} Main"
    '';
  };
}
