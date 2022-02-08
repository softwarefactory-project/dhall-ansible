# ansible-collection-to-dhall

A script to convert an Ansible collection to Dhall schemas.

## Usage

Install ansible-doc:

```shell
$ python3 -mvenv venv
$ ./venv/bin/pip install ansible
```

Run the tool:

```shell
$ cabal run ansible-collection-to-dhall -- --ansible_doc ./venv/bin/ansible-doc --collection openstack.cloud --output openstack-collection/
```

Update builtins:

```shell
$ cabal run ansible-collection-to-dhall -- --ansible_doc ./venv/bin/ansible-doc --builtin --output ../Ansible/
$ cd ..; shake
```

## With nix

Create a nix-shell with both ansible-colleciton-to-dhall and the shake rules using this expression (and update the commit if needed):

```nix
let
  pkgs = import <nixpkgs> {};
  dhall-ansible = pkgs.fetchFromGitHub {
    owner =  "softwarefactory-project";
    repo = "dhall-ansible";
    rev = "ed0acc275b3fe70efaf4e96b645721df91b236b1";
    sha256 = "sha256-cJvQsT5SDxUzvHuNmfHrZ+ufyOzZw6qIqLbQb7Jmexc=";
  };
  shake-factory = pkgs.fetchFromGitHub {
    owner =  "softwarefactory-project";
    repo = "shake-factory";
    rev = "44895e0a005b6cec4722d57e3dc5c37a51b8ee0f";
    sha256 = "sha256-LaUCy6qFiB/iulWFe3vf6R4l1FsFtlLVJd5aoElNyQU=";
  };
  ansible-collection-to-dhall =
    pkgs.callPackage (dhall-ansible + "/ansible-collection-to-dhall") {};
  shake = import shake-factory;
in
  pkgs.mkShell {
    buildInputs = [ ansible-collection-to-dhall ] ++ shake;
  }
```
