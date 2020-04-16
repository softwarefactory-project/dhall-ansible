let Ansible =
      https://raw.githubusercontent.com/TristanCacqueray/dhall-ansible/master/package.dhall

in  [ Ansible.Play::{
      , hosts = "localhost"
      , tasks = Some
        [ Ansible.Task::{
          , debug = Some Ansible.Debug::{ msg = Some "Hello world" }
          }
        , Ansible.Task::{
          , name = Some "Installing package"
          , package = Some Ansible.Package::{
            , name = "emacs-nox"
            , state = "present"
            }
          }
        ]
      }
    ]
