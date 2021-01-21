{ timeout : Optional Natural
, state : Optional ./state.dhall
, sleep : Optional Natural
, search_regex : Optional Text
, port : Optional Natural
, path : Optional Text
, msg : Optional Text
, host : Optional Text
, exclude_hosts : Optional (List Text)
, delay : Optional Natural
, connect_timeout : Optional Natural
, active_connection_states : Optional (List Text)
}