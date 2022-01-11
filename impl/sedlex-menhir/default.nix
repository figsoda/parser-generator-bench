{ ocamlPackages }:

let inherit (ocamlPackages) buildDunePackage menhir menhirLib sedlex_2; in

buildDunePackage {
  pname = "calc-sedlex-menhir";
  version = "0.1.0";

  src = ./.;

  useDune2 = true;

  buildInputs = [ menhir menhirLib sedlex_2 ];
}
