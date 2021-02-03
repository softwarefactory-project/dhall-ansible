let Task = ./BlockTask.dhall

in  { Type = Task.Type //\\ (./mkBlock.dhall Task.Type).Type
    , default = Task.default // (./mkBlock.dhall Task.Type).default
    }
