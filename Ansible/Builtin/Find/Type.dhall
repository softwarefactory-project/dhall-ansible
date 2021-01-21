{ get_checksum : Optional Bool
, recurse : Optional Bool
, size : Optional Text
, age : Optional Text
, file_type : Optional ./file_type.dhall
, use_regex : Optional Bool
, age_stamp : Optional ./age_stamp.dhall
, hidden : Optional Bool
, depth : Optional Natural
, excludes : Optional (List Text)
, patterns : Optional (List Text)
, contains : Optional Text
, paths : List Text
, follow : Optional Bool
}