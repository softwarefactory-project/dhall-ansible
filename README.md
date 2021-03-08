# dhall-ansible

`dhall-ansible` contains [Dhall][dhall-lang] bindings to [Ansible][ansible],
so you can generate Ansible playbooks from Dhall expressions.
This will let you easily typecheck, template and modularize your Ansible playbooks.

See the [dhall-kubernetes][dhall-kubernetes] demonstration for a concrete example of
why you might want to do this.

## Example

A basic playbook using builtin modules:

```dhall
-- ./examples/demo.dhall
let Ansible = ../package.dhall

in  [ Ansible.Play::{
      , hosts = "localhost"
      , vars = Some (Ansible.Vars.mapText (toMap { var_name = "var_value" }))
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
        , Ansible.Task::{
          , block = Some
            [ Ansible.BlockTask::{
              , name = Some "Failing Block task"
              , fail = Some Ansible.Fail::{ msg = Some "oops" }
              }
            ]
          , rescue = Some
            [ Ansible.BlockTask::{
              , name = Some "Rescue task"
              , debug = Some Ansible.Debug::{ msg = Some "rescued" }
              }
            ]
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
    - block:
        - fail:
            msg: oops
          name: Failing Block task
      rescue:
        - debug:
            msg: rescued
          name: Rescue task
  vars:
    var_name: var_value

```

To use collection, a custom Ansible package can be defined:

```dhall
-- ./examples/ansible-posix.dhall
let Base = ../package.dhall

let Posix =
      https://softwarefactory-project.io/cgit/software-factory/dhall-ansible-collection-ansible-posix/plain/package.dhall?h=0.1.0 sha256:c1b127b528be28294629ee1f8b0d8fc951c7282caaffab6ca675f931ea1450c7

let --| Here the task type is extended with the Posix collection
    Task =
      { Type = Base.BaseTask.Type //\\ Posix.Task.Type
      , default = Base.BaseTask.default // Posix.Task.default
      }

let --| The new task type can be added to the Play too
    Play =
      { Type = Base.BasePlay.Type //\\ { tasks : List Task.Type }
      , default = Base.BasePlay.default
      }

in  Base // { Task, Play, Posix }

```

And a playbook can be defined as follow:

```dhall
-- ./examples/posix.dhall
let Ansible = ./ansible-posix.dhall

in  [ Ansible.Play::{
      , hosts = "localhost"
      , tasks =
        [ Ansible.Task::{
          , name = Some "Synchronize demo"
          , `ansible.posix.synchronize` = Some Ansible.Posix.Synchronize::{
            , src = "/tmp/test"
            , dest = "/tmp/dest"
            }
          }
        ]
      }
    ]

```

```yaml
# dhall-to-yaml --file examples/posix.dhall

- hosts: localhost
  tasks:
    - ansible.posix.synchronize:
        dest: /tmp/dest
        src: /tmp/test
      name: Synchronize demo

```

Here is a custom package including the ansible.posix and openstack.cloud collection:

```dhall
-- ./examples/ansible-extended.dhall
-- | The ansible schemas using the posix and podman collections
let Base =
      https://softwarefactory-project.io/cgit/software-factory/dhall-ansible/plain/package.dhall?h=0.2.1 sha256:030d7d1b16172afde44843c6e950fcc3382a6653269e36a27ca1d06d75a631ff

let Posix =
      https://softwarefactory-project.io/cgit/software-factory/dhall-ansible-collection-ansible-posix/plain/package.dhall?h=0.1.0 sha256:c1b127b528be28294629ee1f8b0d8fc951c7282caaffab6ca675f931ea1450c7

let Podman =
      https://softwarefactory-project.io/cgit/software-factory/dhall-ansible-collection-containers-podman/plain/package.dhall?h=0.1.0 sha256:469dcbf0d4466677c87b4734e8c405b50f5a336de688e30a75db7db126c20a81

let BlockTask =
      { Type =
              Base.BaseTask.Type
          //\\  Base.Builtin.Task.Type
          //\\  Posix.Task.Type
          //\\  Podman.Task.Type
      , default =
              Base.BaseTask.default
          //  Base.Builtin.Task.default
          //  Posix.Task.default
          //  Podman.Task.default
      }

let Export = Base // Posix // Podman

let Task =
      { Type = BlockTask.Type //\\ (Base.mkBlock BlockTask.Type).Type
      , default = BlockTask.default // (Base.mkBlock BlockTask.Type).default
      }

let --| The new task type can be added to the Play too
    Play =
      { Type =
              Base.BasePlay.Type
          //\\  { tasks : Optional (List Task.Type)
                , pre_tasks : Optional (List Task.Type)
                , post_tasks : Optional (List Task.Type)
                , handlers : Optional (List Task.Type)
                }
      , default =
              Base.BasePlay.default
          //  { tasks = None (List Task.Type)
              , pre_tasks = None (List Task.Type)
              , post_tasks = None (List Task.Type)
              , handlers = None (List Task.Type)
              }
      }

in  Export // { Task, Play }

```

## Changes

Frozen packages are available in the tag commit.

### 0.2.1

- Import Zuul.Vars locally

### 0.2.0

- Major refactor to support Ansible Collections
- Change vars type to JSON/Type
- Add block support

### 0.1.0

- Initial release for ansible-2.9

[dhall-lang]: https://dhall-lang.org
[ansible]: https://ansible.com
[dhall-kubernetes]: https://github.com/dhall-lang/dhall-kubernetes
[type-operator]: https://docs.dhall-lang.org/references/Built-in-types.html#id70
