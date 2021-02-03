-- | A function to enable playbooks_block, see the Task.dhall for usage
\(task : Type) ->
  { Type =
      { block : Optional (List task)
      , always : Optional (List task)
      , rescue : Optional (List task)
      }
  , default =
    { block = None (List task)
    , always = None (List task)
    , rescue = None (List task)
    }
  }
