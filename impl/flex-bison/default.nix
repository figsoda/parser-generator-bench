{ stdenv, bison, flex }:

stdenv.mkDerivation {
  pname = "calc-flex-bison";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [ bison flex ];
}
