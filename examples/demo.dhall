let ansible =
      https://raw.githubusercontent.com/TristanCacqueray/dhall-ansible/master/package.dhall sha256:da945f14b9acc74584624595e9d75c1c91bb3938d35464f18f14dd90845fcf30

in  [ ansible.Play::{
      , hosts = "localhost"
      , tasks =
        [ ansible.Task::{
          , debug = Some ansible.Debug::{ msg = Some "Hello world" }
          }
        , ansible.Task::{
          , name = Some "Installing package"
          , package = Some ansible.Package::{
            , name = "emacs-nox"
            , state = "present"
            }
          }
        ]
      }
    ]
