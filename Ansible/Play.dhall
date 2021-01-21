let Task = ./Task.dhall

let BasePlay = ./BasePlay/package.dhall

let TaskList =
      { Type = Optional (List Task.Type), default = None (List Task.Type) }

in  { Type =
            BasePlay.Type
        //\\  { tasks : TaskList.Type
              , pre_tasks : TaskList.Type
              , post_tasks : TaskList.Type
              , handlers : TaskList.Type
              }
    , default =
            BasePlay.default
        //  { tasks = TaskList.default
            , pre_tasks = TaskList.default
            , post_tasks = TaskList.default
            , handlers = TaskList.default
            }
    }
