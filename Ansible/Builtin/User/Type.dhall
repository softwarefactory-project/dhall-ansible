{ append : Optional Bool
, authorization : Optional Text
, comment : Optional Text
, create_home : Optional Bool
, expires : Optional Double
, force : Optional Bool
, generate_ssh_key : Optional Bool
, group : Optional Text
, groups : Optional (List Text)
, hidden : Optional Bool
, home : Optional Text
, local : Optional Bool
, login_class : Optional Text
, move_home : Optional Bool
, name : Text
, non_unique : Optional Bool
, password : Optional Text
, password_lock : Optional Bool
, profile : Optional Text
, remove : Optional Bool
, role : Optional Text
, seuser : Optional Text
, shell : Optional Text
, skeleton : Optional Text
, ssh_key_bits : Optional Natural
, ssh_key_comment : Optional Text
, ssh_key_file : Optional Text
, ssh_key_passphrase : Optional Text
, ssh_key_type : Optional Text
, state : Optional ./state.dhall
, system : Optional Bool
, uid : Optional Natural
, update_password : Optional ./update_password.dhall
}