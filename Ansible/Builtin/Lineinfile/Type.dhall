{ validate : Optional Text
, unsafe_writes : Optional Bool
, state : Optional ./state.dhall
, seuser : Optional Text
, setype : Optional Text
, serole : Optional Text
, selevel : Optional Text
, regexp : Optional Text
, path : Text
, owner : Optional Text
, others : Optional Text
, mode : Optional Text
, line : Optional Text
, insertbefore : Optional ./insertbefore.dhall
, insertafter : Optional ./insertafter.dhall
, group : Optional Text
, firstmatch : Optional Bool
, create : Optional Bool
, backup : Optional Bool
, backrefs : Optional Bool
, attributes : Optional Text
}