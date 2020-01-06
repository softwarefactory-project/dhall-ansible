let ansible = ../package.dhall

in  ansible.Play::{
    , hosts = "localhost"
    , tasks =
        [ ansible.Task::{
          , debug = Some ansible.Debug::{ msg = Some "Hello world" }
          }
        ]
    }
