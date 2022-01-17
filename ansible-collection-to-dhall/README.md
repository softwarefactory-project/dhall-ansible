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
