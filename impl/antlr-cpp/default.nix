{ antlr4_9, llvmPackages_latest, gccStdenv }:

let antlr = antlr4_9; in

builtins.mapAttrs
  (compiler: stdenv:
    stdenv.mkDerivation {
      pname = "calc-antlr-cpp-${compiler}";
      version = "0.1.0";

      src = ./.;

      nativeBuildInputs = [ antlr ];

      RUNTIME_INCLUDE = antlr.runtime.cpp.dev;
      RUNTIME_LIB = antlr.runtime.cpp;
    }
  )
{
  clang = llvmPackages_latest.stdenv;
  gcc = gccStdenv;
}
