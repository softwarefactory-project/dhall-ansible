{ attributes : Optional Text
, body : Optional Text
, body_format : Optional ./body_format.dhall
, ca_path : Optional Text
, client_cert : Optional Text
, client_key : Optional Text
, creates : Optional Text
, dest : Optional Text
, follow_redirects : Optional ./follow_redirects.dhall
, force : Optional Bool
, force_basic_auth : Optional Bool
, group : Optional Text
, headers : Optional ../JSON.dhall
, http_agent : Optional Text
, method : Optional Text
, mode : Optional Text
, owner : Optional Text
, remote_src : Optional Bool
, removes : Optional Text
, return_content : Optional Bool
, selevel : Optional Text
, serole : Optional Text
, setype : Optional Text
, seuser : Optional Text
, src : Optional Text
, status_code : Optional (List Text)
, timeout : Optional Natural
, unix_socket : Optional Text
, unredirected_headers : Optional (List Text)
, unsafe_writes : Optional Bool
, url : Text
, url_password : Optional Text
, url_username : Optional Text
, use_gssapi : Optional Bool
, use_proxy : Optional Bool
, validate_certs : Optional Bool
}