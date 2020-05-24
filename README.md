# dhall-ansible

`dhall-ansible` contains [Dhall][dhall-lang] bindings to [Ansible][Ansible],
so you can generate Ansible playbooks from Dhall expressions.
This will let you easily typecheck, template and modularize your Ansible playbooks.

See the [dhall-kubernetes][dhall-kubernetes] demonstration for a concrete example of
why you might want to do this.

## Contribute

Pull Request are welcome. Only the `types/` files or the `scripts/generate.py` script needs
to be updated, then run the `make` command to update the schemas and defaults.

For example to add new module, create a file name `types/modules/${module-name}.dhall` and `make`
will update the `types/task.dhall` and schemas files.

Only the simplified type for `play.hosts`, `play.roles`, `play.vars` and `tasks.vars` is
currently supported. The alternative are:
* Support only the complex type (List Text, List RoleDict, JSON/Type vars).
* Support both using an Union <Simplified | Complex> form.


## Example

```dhall
{- ./examples/demo.dhall -}
let Ansible =
      https://raw.githubusercontent.com/TristanCacqueray/dhall-ansible/master/package.dhall

in  [ Ansible.Play::{
      , hosts = "localhost"
      , vars = Some (toMap { var_name = "var_value" })
      , tasks = Some
        [ Ansible.Task::{
          , debug = Some Ansible.Debug::{ msg = Some "Hello world" }
          }
        , Ansible.Task::{
          , name = Some "Installing package"
          , become = Some True
          , package = Some Ansible.Package::{
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
        msg: Hello world
    - become: true
      name: Installing package
      package:
        name: emacs-nox
        state: present
  vars:
    var_name: var_value

```


[dhall-lang]: https://dhall-lang.org
[Ansible]: https://ansible.com
[dhall-kubernetes]: https://github.com/dhall-lang/dhall-kubernetes
