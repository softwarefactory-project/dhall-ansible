let Base = ../package.dhall

let -- TODO: replace with tagged URL
    Posix =
      ../../dhall-ansible-collection-ansible.posix/package.dhall

let Openstack = ../../dhall-ansible-collection-openstack.cloud/package.dhall

let Task =
      { Type = Base.Task.Type //\\ Posix.Task.Type //\\ Openstack.Task.Type
      , default =
          Base.Task.default // Posix.Task.default // Openstack.Task.default
      }

let Play =
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

in  Base // { Task, Play, Posix }
