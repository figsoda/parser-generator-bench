{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, fenix, nixpkgs }: {
    packages = nixpkgs.lib.genAttrs nixpkgs.lib.systems.supported.hydra
      (system:
        builtins.mapAttrs
          (name: _: (import nixpkgs {
            localSystem = { inherit system; };
            overlays = [ fenix.overlay ];
          }).callPackage ./impl/${name}
            { })
          (builtins.readDir ./impl));
  };
}
