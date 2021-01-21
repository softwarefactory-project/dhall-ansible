{ ssh_key_comment : Optional Text
, create_home : Optional Bool
, groups : Optional (List Text)
, generate_ssh_key : Optional Bool
, home : Optional Text
, state : Optional ./state.dhall
, group : Optional Text
, force : Optional Bool
, system : Optional Bool
, local : Optional Bool
, uid : Optional Natural
, expires : Optional Double
, ssh_key_passphrase : Optional Text
, password_lock : Optional Bool
, authorization : Optional Text
, ssh_key_bits : Optional Natural
, profile : Optional Text
, non_unique : Optional Bool
, shell : Optional Text
, remove : Optional Bool
, ssh_key_file : Optional Text
, update_password : Optional ./update_password.dhall
, skeleton : Optional Text
, role : Optional Text
, name : Text
, password : Optional Text
, ssh_key_type : Optional Text
, seuser : Optional Text
, hidden : Optional Bool
, login_class : Optional Text
, comment : Optional Text
, append : Optional Bool
, move_home : Optional Bool
}