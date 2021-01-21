let Base = ../package.dhall

let Posix =
      https://softwarefactory-project.io/cgit/software-factory/dhall-ansible-collection-ansible-posix/plain/package.dhall?h=0.1.0 sha256:c1b127b528be28294629ee1f8b0d8fc951c7282caaffab6ca675f931ea1450c7

let Openstack =
      https://softwarefactory-project.io/cgit/software-factory/dhall-ansible-collection-openstack-cloud/plain/package.dhall?h=0.1.0 sha256:ced909353da20eb8d8a088c59a91f822ed2e069923a7fd2e901b55398343f3fe

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
