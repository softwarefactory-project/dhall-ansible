let Ansible =
      https://raw.githubusercontent.com/TristanCacqueray/dhall-ansible/v0.1.0/package.dhall sha256:a868e39f7cf255cfe5addc1639e0f4dc175a1ba95576da519fda2be72f1bcfb7

in  [ Ansible.Play::{
      , hosts = "localhost"
      , tasks =
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
