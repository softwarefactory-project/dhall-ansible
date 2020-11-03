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
