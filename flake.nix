{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gocc-src = {
      url = "github:goccmack/gocc";
      flake = false;
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, fenix, gocc-src, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      forHydraSystems = lib.genAttrs lib.systems.supported.hydra;
    in
    {
      packages = forHydraSystems (system:
        builtins.mapAttrs
          (name: _: (import nixpkgs {
            localSystem = { inherit system; };
            overlays = [
              fenix.overlay
              (_: _: { inherit gocc-src; })
            ];
          }).callPackage ./impl/${name}
            { })
          (builtins.readDir ./impl));

      defaultPackage = forHydraSystems (system:
        let
          inherit (nixpkgs.legacyPackages.${system}) dash hyperfine
            makeRustPlatform writers;
          p = self.packages.${system};
        in
        writers.writeDashBin "benchmark" ''
          cd "$(mktemp -d data-XXX)"

          ${(makeRustPlatform {
            inherit (fenix.packages.${system}.minimal) cargo rustc;
          }).buildRustPackage {
            pname = "gen";
            version = "0.1.0";

            src = ./gen;

            cargoLock.lockFile = ./gen/Cargo.lock;
          }}/bin/gen

          ${hyperfine}/bin/hyperfine \
            -w 10 -r 100 -s none -S ${dash}/bin/dash \
            --export-json results.json \
            ${
              builtins.concatStringsSep " "
              (lib.mapAttrsFlatten (k: v: ''-n ${k} "${v}/bin/${v.pname} < input"'') {
                inherit (p) alex-happy antlr-go flex-bison gocc
                  ocamllex-ocamlyacc sedlex-menhir;
                inherit (p.rust) grmtools lalrpop peg;
                antlr-cpp-clang = p.antlr-cpp.clang;
                antlr-cpp-gcc = p.antlr-cpp.gcc;
                antlr-java-graal = p.antlr-java.graal;
                antlr-java-openjdk = p.antlr-java.openjdk;
              })
            }
        ''
      );
    };
}
