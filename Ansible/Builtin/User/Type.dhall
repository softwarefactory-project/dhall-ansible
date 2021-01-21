{ update_password : Optional ./update_password.dhall
, uid : Optional Natural
, system : Optional Bool
, state : Optional ./state.dhall
, ssh_key_type : Optional Text
, ssh_key_passphrase : Optional Text
, ssh_key_file : Optional Text
, ssh_key_comment : Optional Text
, ssh_key_bits : Optional Natural
, skeleton : Optional Text
, shell : Optional Text
, seuser : Optional Text
, role : Optional Text
, remove : Optional Bool
, profile : Optional Text
, password_lock : Optional Bool
, password : Optional Text
, non_unique : Optional Bool
, name : Text
, move_home : Optional Bool
, login_class : Optional Text
, local : Optional Bool
, home : Optional Text
, hidden : Optional Bool
, groups : Optional (List Text)
, group : Optional Text
, generate_ssh_key : Optional Bool
, force : Optional Bool
, expires : Optional Double
, create_home : Optional Bool
, comment : Optional Text
, authorization : Optional Text
, append : Optional Bool
}