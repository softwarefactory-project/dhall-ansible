{ validate : Optional Text
, unsafe_writes : Optional Bool
, state : Optional ./state.dhall
, seuser : Optional Text
, setype : Optional Text
, serole : Optional Text
, selevel : Optional Text
, path : Text
, owner : Optional Text
, mode : Optional Text
, marker_end : Optional Text
, marker_begin : Optional Text
, marker : Optional Text
, insertbefore : Optional ./insertbefore.dhall
, insertafter : Optional ./insertafter.dhall
, group : Optional Text
, create : Optional Bool
, block : Optional Text
, backup : Optional Bool
, attributes : Optional Text
}