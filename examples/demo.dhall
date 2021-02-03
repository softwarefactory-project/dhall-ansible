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
