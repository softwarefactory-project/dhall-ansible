{ return_content : Optional Bool
, creates : Optional Text
, group : Optional Text
, validate_certs : Optional Bool
, serole : Optional Text
, force : Optional Bool
, removes : Optional Text
, body : Optional Text
, use_proxy : Optional Bool
, mode : Optional Text
, url : Text
, dest : Optional Text
, http_agent : Optional Text
, client_key : Optional Text
, owner : Optional Text
, body_format : Optional ./body_format.dhall
, headers : Optional ../JSON.dhall
, method : Optional Text
, follow_redirects : Optional ./follow_redirects.dhall
, force_basic_auth : Optional Bool
, seuser : Optional Text
, attributes : Optional Text
, url_username : Optional Text
, src : Optional Text
, unix_socket : Optional Text
, selevel : Optional Text
, url_password : Optional Text
, timeout : Optional Natural
, unsafe_writes : Optional Bool
, status_code : Optional (List Text)
, setype : Optional Text
, client_cert : Optional Text
, remote_src : Optional Bool
}