{ to_source = None Text
, uid_owner = None Text
, table = None ./table.dhall
, comment = None Text
, log_prefix = None Text
, set_dscp_mark = None Text
, match = None (List Text)
, dst_range = None Text
, icmp_type = None Text
, policy = None ./policy.dhall
, limit = None Text
, source = None Text
, chain = None Text
, set_counters = None Text
, set_dscp_mark_class = None Text
, tcp_flags = None ../JSON.dhall
, gid_owner = None Text
, out_interface = None Text
, ip_version = None ./ip_version.dhall
, protocol = None Text
, action = None ./action.dhall
, to_ports = None Text
, source_port = None Text
, goto = None Text
, wait = None Text
, to_destination = None Text
, fragment = None Text
, gateway = None Text
, limit_burst = None Text
, ctstate = None (List Text)
, in_interface = None Text
, log_level = None ./log_level.dhall
, destination_port = None Text
, reject_with = None Text
, jump = None Text
, src_range = None Text
, state = None ./state.dhall
, rule_num = None Text
, syn = None ./syn.dhall
, flush = None Bool
, destination = None Text
}