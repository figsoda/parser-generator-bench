{ stdenv, antlr4_9 }:

let antlr = antlr4_9; in

stdenv.mkDerivation {
  pname = "calc-antlr-cpp";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [ antlr ];

  RUNTIME_INCLUDE = antlr.runtime.cpp.dev;
  RUNTIME_LIB = antlr.runtime.cpp;
}
