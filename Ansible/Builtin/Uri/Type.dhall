{ validate_certs : Optional Bool
, use_proxy : Optional Bool
, url_username : Optional Text
, url_password : Optional Text
, url : Text
, unsafe_writes : Optional Bool
, unix_socket : Optional Text
, timeout : Optional Natural
, status_code : Optional (List Text)
, src : Optional Text
, seuser : Optional Text
, setype : Optional Text
, serole : Optional Text
, selevel : Optional Text
, return_content : Optional Bool
, removes : Optional Text
, remote_src : Optional Bool
, owner : Optional Text
, mode : Optional Text
, method : Optional Text
, http_agent : Optional Text
, headers : Optional ../JSON.dhall
, group : Optional Text
, force_basic_auth : Optional Bool
, force : Optional Bool
, follow_redirects : Optional ./follow_redirects.dhall
, dest : Optional Text
, creates : Optional Text
, client_key : Optional Text
, client_cert : Optional Text
, body_format : Optional ./body_format.dhall
, body : Optional Text
, attributes : Optional Text
}