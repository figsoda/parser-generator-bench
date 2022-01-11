{ makeRustPlatform, fenix }:

builtins.mapAttrs
  (name: _: (makeRustPlatform {
    inherit (fenix.minimal) cargo rustc;
  }).buildRustPackage rec {
    pname = "calc-${name}";
    version = "0.1.0";

    src = ./.;

    cargoLock.lockFile = ./Cargo.lock;

    cargoBuildFlags = [ "--bin" pname ];
  })
  (builtins.readDir ./bin)
