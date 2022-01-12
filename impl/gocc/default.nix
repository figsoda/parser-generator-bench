{ buildGoModule, gocc-src }:

let
  gocc = buildGoModule {
    pname = "gocc";
    version = "0.0.0+date=${builtins.substring 0 8 gocc-src.lastModifiedDate}";

    src = gocc-src;

    vendorSha256 = "sha256-O2/yjnlLI5/hq2wrPS9N/uBcooIj8CaIkJEvHfjnXqs=";

    preCheck = ''
      export PATH=$PATH:$GOPATH/bin
    '';
  };
in

buildGoModule {
  pname = "calc-gocc";
  version = "0.1.0";

  src = ./.;

  vendorSha256 = null;

  nativeBuildInputs = [ gocc ];

  preBuild = ''
    gocc calc.bnf
  '';
}
