{ attributes : Optional Text
, backup : Optional Bool
, checksum : Optional Text
, client_cert : Optional Text
, client_key : Optional Text
, dest : Text
, force : Optional Bool
, force_basic_auth : Optional Bool
, group : Optional Text
, headers : Optional ../JSON.dhall
, http_agent : Optional Text
, mode : Optional Text
, owner : Optional Text
, selevel : Optional Text
, serole : Optional Text
, setype : Optional Text
, seuser : Optional Text
, sha256sum : Optional Text
, timeout : Optional Natural
, tmp_dest : Optional Text
, unredirected_headers : Optional (List Text)
, unsafe_writes : Optional Bool
, url : Text
, url_password : Optional Text
, url_username : Optional Text
, use_gssapi : Optional Bool
, use_proxy : Optional Bool
, validate_certs : Optional Bool
}