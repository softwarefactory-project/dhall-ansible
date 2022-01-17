{ withHoogle ? false}:
let
  nixpkgs = import (fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/a6f258f49fcd1644f08b7b3677da2c5e55713291.tar.gz")
    { };
  name = "ansible-collection-to-dhall";
  drv = nixpkgs.haskellPackages.callCabal2nix name ./. { };
  shellDrv = nixpkgs.haskellPackages.shellFor {
    withHoogle = withHoogle;
    packages = p: [ drv ];
    buildInputs = with nixpkgs.haskellPackages; [ hlint cabal-install ];
  };
in if nixpkgs.lib.inNixShell then shellDrv else drv
