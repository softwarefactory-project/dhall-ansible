{ virtualenv_site_packages : Optional Bool
, virtualenv_python : Optional Text
, virtualenv_command : Optional Text
, virtualenv : Optional Text
, version : Optional Text
, umask : Optional Text
, state : Optional ./state.dhall
, requirements : Optional Text
, name : Optional (List Text)
, extra_args : Optional Text
, executable : Optional Text
, editable : Optional Bool
, chdir : Optional Text
}