{ use_regex : Optional Bool
, size : Optional Text
, recurse : Optional Bool
, patterns : Optional (List Text)
, paths : List Text
, hidden : Optional Bool
, get_checksum : Optional Bool
, follow : Optional Bool
, file_type : Optional ./file_type.dhall
, excludes : Optional (List Text)
, depth : Optional Natural
, contains : Optional Text
, age_stamp : Optional ./age_stamp.dhall
, age : Optional Text
}