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
