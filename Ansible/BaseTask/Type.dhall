{ name : Optional Text
, set_fact : Optional ../Builtin/JSON.dhall
, vars : Optional ../Builtin/JSON.dhall
, loop : Optional Text
, loop_control : Optional ./loop_control.dhall
, action : Optional Text
, async_val : Optional Natural
, delay : Optional Natural
, delegate_to : Optional Text
, delegate_facts : Optional Bool
, no_log : Optional Bool
, become : Optional Bool
, become_method : Optional Text
, become_user : Optional Text
, become_flags : Optional Text
, notify : Optional (List Text)
, listen : Optional Text
, poll : Optional Natural
, retries : Optional Natural
, until : Optional Text
, register : Optional Text
, ignore_errors : Optional Bool
, failed_when : Optional Text
, changed_when : Optional Text
, when : Optional Text
}
