{ hosts : Text
, vars : Optional ./map_text.dhall
, gather_facts : Optional Bool
, gather_subset : Optional (List Text)
, gather_timeout : Optional Natural
, fact_path : Optional Text
, vars_files : Optional (List Text)
, vars_prompt : Optional (List Text)
, roles : Optional (List Text)
, handlers : Optional (List ./task.dhall)
, pre_tasks : Optional (List ./task.dhall)
, post_tasks : Optional (List ./task.dhall)
, tasks : Optional (List ./task.dhall)
, force_handlers : Optional Bool
, max_fail_percentage : Optional Double
, serial : Optional (List Text)
, strategy : Optional Text
, order : Optional Text
, become : Optional Bool
, become_method : Optional Text
, become_user : Optional Text
, become_flags : Optional Text
}
