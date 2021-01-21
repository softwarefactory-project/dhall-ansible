# dhall-ansible

`dhall-ansible` contains [Dhall][dhall-lang] bindings to [Ansible][ansible],
so you can generate Ansible playbooks from Dhall expressions.
This will let you easily typecheck, template and modularize your Ansible playbooks.

See the [dhall-kubernetes][dhall-kubernetes] demonstration for a concrete example of
why you might want to do this.

## Example

```dhall
-- ./examples/demo.dhall
let Ansible = ../package.dhall

in  [ Ansible.Play::{
      , hosts = "localhost"
      , vars = Some (Ansible.Vars.mapText (toMap { var_name = "var_value" }))
      }
    ]

```

```yaml
# dhall-to-yaml --file examples/demo.dhall

- hosts: localhost
  vars:
    var_name: var_value

```

## Extend

To use custom modules, the Task type may be extended with the [//\\ operator][type-operator]:

```dhall
let Ansible = ../package.dhall

let MyModule = { Type = { attribute : Bool }, default = {=} }

let Task =
      { Type = Ansible.Task.Type //\\ { my-module : Optional MyModule.Type }
      , default = Ansible.Task.default // { my-module = None MyModule.Type }
      }

in  [ { hosts = "localhost"
      , tasks =
        [ Task::{
          , name = Some "my-module usage"
          , my-module = Some MyModule::{ attribute = True }
          }
        ]
      }
    ]

```

```yaml
# # dhall-to-yaml --file examples/custom.dhall
- hosts: localhost
  tasks:
    - my-module:
        attribute: true
      name: my-module usage
```

## Changes

Frozen packages are available in the tag commit.

### 0.2.0

- Major refactor to support Ansible Collections

### 0.1.0

- Initial release for ansible-2.9

[dhall-lang]: https://dhall-lang.org
[ansible]: https://ansible.com
[dhall-kubernetes]: https://github.com/dhall-lang/dhall-kubernetes
[type-operator]: https://docs.dhall-lang.org/references/Built-in-types.html#id70
