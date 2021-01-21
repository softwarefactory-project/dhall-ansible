let
  nixpkgs = import (fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/d4f19a218cbb15a242864a49f8b9f16fb7d48ec8.tar.gz")
    { };
  name = "ansible-collection-to-dhall";
  drv = nixpkgs.haskellPackages.callCabal2nix name ./. { };
  shellDrv = nixpkgs.haskellPackages.shellFor {
    withHoogle = true;
    packages = p: [ drv ];
    buildInputs = with nixpkgs.haskellPackages; [ hlint cabal-install ];
  };
in if nixpkgs.lib.inNixShell then shellDrv else drv
