{ stdenv, haskellPackages }:

stdenv.mkDerivation {
  pname = "calc-alex-happy";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = with haskellPackages; [ alex ghc happy ];
}
