{- Created from https://github.com/ansible/ansible/blob/ac509d489bdfb23dcf5cd1694473abb7cb0cf4aa/lib/ansible/playbook/play.py#L43 -}
{ hosts : Text
, gather_facts : Optional Bool
, gather_subset : Optional (List Text)
, gather_timeout : Optional Natural
, fact_path : Optional Text
, vars_files : Optional (List Text)
, vars_prompt : Optional (List Text)
, roles : Optional (List Text)
, handlers : Optional (List Text)
, pre_tasks : Optional (List ./task.dhall)
, post_tasks : Optional (List ./task.dhall)
, tasks : Optional (List ./task.dhall)
, force_handlers : Optional Bool
, max_fail_percentage : Optional Double
, serial : Optional (List Text)
, strategy : Optional Text
, order : Optional Text
}
