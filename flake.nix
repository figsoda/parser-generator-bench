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

  outputs = { self, fenix, gocc-src, nixpkgs }: {
    packages = nixpkgs.lib.genAttrs nixpkgs.lib.systems.supported.hydra
      (system:
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
  };
}
