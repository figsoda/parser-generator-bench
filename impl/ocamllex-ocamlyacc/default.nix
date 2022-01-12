{ ocamlPackages }:

ocamlPackages.buildDunePackage {
  pname = "calc-ocamllex-ocamlyacc";
  version = "0.1.0";

  src = ./.;

  useDune2 = true;
}
