-- | The ansible schemas using the posix and podman collections
let Base =
      https://softwarefactory-project.io/cgit/software-factory/dhall-ansible/plain/package.dhall?h=0.2.1 sha256:030d7d1b16172afde44843c6e950fcc3382a6653269e36a27ca1d06d75a631ff

let Posix =
      https://softwarefactory-project.io/cgit/software-factory/dhall-ansible-collection-ansible-posix/plain/package.dhall?h=0.1.0 sha256:c1b127b528be28294629ee1f8b0d8fc951c7282caaffab6ca675f931ea1450c7

let Podman =
      https://softwarefactory-project.io/cgit/software-factory/dhall-ansible-collection-containers-podman/plain/package.dhall?h=0.1.0 sha256:469dcbf0d4466677c87b4734e8c405b50f5a336de688e30a75db7db126c20a81

let BlockTask =
      { Type =
              Base.BaseTask.Type
          //\\  Base.Builtin.Task.Type
          //\\  Posix.Task.Type
          //\\  Podman.Task.Type
      , default =
              Base.BaseTask.default
          //  Base.Builtin.Task.default
          //  Posix.Task.default
          //  Podman.Task.default
      }

let Export = Base // Posix // Podman

let Task =
      { Type = BlockTask.Type //\\ (Base.mkBlock BlockTask.Type).Type
      , default = BlockTask.default // (Base.mkBlock BlockTask.Type).default
      }

let --| The new task type can be added to the Play too
    Play =
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

in  Export // { Task, Play }
