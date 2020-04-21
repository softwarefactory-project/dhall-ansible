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
