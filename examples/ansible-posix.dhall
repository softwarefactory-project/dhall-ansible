let Base = ../package.dhall

let Posix =
      https://softwarefactory-project.io/cgit/software-factory/dhall-ansible-collection-ansible-posix/plain/package.dhall?h=0.1.0 sha256:c1b127b528be28294629ee1f8b0d8fc951c7282caaffab6ca675f931ea1450c7

let --| Here the task type is extended with the Posix collection
    Task =
      { Type = Base.BaseTask.Type //\\ Posix.Task.Type
      , default = Base.BaseTask.default // Posix.Task.default
      }

let --| The new task type can be added to the Play too
    Play =
      { Type = Base.BasePlay.Type //\\ { tasks : List Task.Type }
      , default = Base.BasePlay.default
      }

in  Base // { Task, Play, Posix }
