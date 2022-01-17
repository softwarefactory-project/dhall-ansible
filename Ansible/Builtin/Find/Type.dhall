{ age : Optional Text
, age_stamp : Optional ./age_stamp.dhall
, contains : Optional Text
, depth : Optional Natural
, excludes : Optional (List Text)
, file_type : Optional ./file_type.dhall
, follow : Optional Bool
, get_checksum : Optional Bool
, hidden : Optional Bool
, paths : List Text
, patterns : Optional (List Text)
, read_whole_file : Optional Bool
, recurse : Optional Bool
, size : Optional Text
, use_regex : Optional Bool
}