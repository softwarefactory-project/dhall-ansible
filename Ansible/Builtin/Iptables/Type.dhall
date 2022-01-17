{ action : Optional ./action.dhall
, chain : Optional Text
, comment : Optional Text
, ctstate : Optional (List Text)
, destination : Optional Text
, destination_port : Optional Text
, destination_ports : Optional (List Text)
, dst_range : Optional Text
, flush : Optional Bool
, fragment : Optional Text
, gateway : Optional Text
, gid_owner : Optional Text
, goto : Optional Text
, icmp_type : Optional Text
, in_interface : Optional Text
, ip_version : Optional ./ip_version.dhall
, jump : Optional Text
, limit : Optional Text
, limit_burst : Optional Text
, log_level : Optional ./log_level.dhall
, log_prefix : Optional Text
, match : Optional (List Text)
, match_set : Optional Text
, match_set_flags : Optional ./match_set_flags.dhall
, out_interface : Optional Text
, policy : Optional ./policy.dhall
, protocol : Optional Text
, reject_with : Optional Text
, rule_num : Optional Text
, set_counters : Optional Text
, set_dscp_mark : Optional Text
, set_dscp_mark_class : Optional Text
, source : Optional Text
, source_port : Optional Text
, src_range : Optional Text
, state : Optional ./state.dhall
, syn : Optional ./syn.dhall
, table : Optional ./table.dhall
, tcp_flags : Optional ../JSON.dhall
, to_destination : Optional Text
, to_ports : Optional Text
, to_source : Optional Text
, uid_owner : Optional Text
, wait : Optional Text
}