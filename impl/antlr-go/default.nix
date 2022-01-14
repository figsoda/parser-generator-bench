{ buildGoModule, antlr4_9 }:

let antlr = antlr4_9; in

buildGoModule {
  pname = "calc-antlr-go";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [ antlr ];

  preBuild = ''
    antlr calc.g4 -Dlanguage=Go -o parser
  '';

  vendorSha256 = "sha256-kf5cFISdXkCmHazLRGgBYpFSucnLu8uhsnfNKtOKrHo=";
}
