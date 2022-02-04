{ pkgs ? import ./nixpkgs.nix }:
pkgs.haskellPackages.callCabal2nix "ansible-collection-to-dhall" ./. { }
