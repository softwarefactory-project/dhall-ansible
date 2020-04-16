{ hosts : Text
, roles : Optional (List Text)
, pre_tasks : Optional (List ./task.dhall)
, post_tasks : Optional (List ./task.dhall)
, tasks : List ./task.dhall
}
