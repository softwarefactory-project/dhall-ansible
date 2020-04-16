# dhall-ansible

`dhall-ansible` contains [Dhall][dhall-lang] bindings to [Ansible][Ansible],
so you can generate Ansible playbooks from Dhall expressions.
This will let you easily typecheck, template and modularize your Ansible playbooks.


## Example

```dhall
{- ./examples/demo.dhall -}
let ansible =
      https://raw.githubusercontent.com/TristanCacqueray/dhall-ansible/master/package.dhall sha256:da945f14b9acc74584624595e9d75c1c91bb3938d35464f18f14dd90845fcf30

in  [ ansible.Play::{
      , hosts = "localhost"
      , tasks =
        [ ansible.Task::{
          , debug = Some ansible.Debug::{ msg = Some "Hello world" }
          }
        , ansible.Task::{
          , name = Some "Installing package"
          , package = Some ansible.Package::{
            , name = "emacs-nox"
            , state = "present"
            }
          }
        ]
      }
    ]

```

```yaml
# dhall-to-yaml --file examples/demo.dhall
- hosts: localhost
  tasks:
    - debug:
        msg: "Hello world"
    - name: "Installing package"
      package:
        name: emacs-nox
        state: present

```

## Adding new modules

Update the scripts/generate.py file or simply write a new `types/modules/${module-name}.dhall` file
and run the `make` command to update the schemas and defaults.

[dhall-lang]: https://dhall-lang.org
[Ansible]: https://ansible.com
