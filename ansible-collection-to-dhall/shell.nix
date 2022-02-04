{ withHoogle ? false }:
let
  nixpkgs = import ./nixpkgs.nix;
  drv = import ./default.nix { };
in nixpkgs.haskellPackages.shellFor {
  withHoogle = withHoogle;
  packages = p: [ drv ];
  buildInputs = with nixpkgs.haskellPackages; [ hlint cabal-install ];
}
