{ state : Optional ./state.dhall
, group : Optional Text
, serole : Optional Text
, path : Text
, mode : Optional Text
, line : Optional Text
, insertbefore : Optional ./insertbefore.dhall
, backup : Optional Bool
, backrefs : Optional Bool
, owner : Optional Text
, create : Optional Bool
, others : Optional Text
, seuser : Optional Text
, attributes : Optional Text
, regexp : Optional Text
, selevel : Optional Text
, insertafter : Optional ./insertafter.dhall
, unsafe_writes : Optional Bool
, setype : Optional Text
, validate : Optional Text
, firstmatch : Optional Bool
}