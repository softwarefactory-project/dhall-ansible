{ attributes = None Text
, body = None Text
, body_format = None ./body_format.dhall
, ca_path = None Text
, client_cert = None Text
, client_key = None Text
, creates = None Text
, dest = None Text
, follow_redirects = None ./follow_redirects.dhall
, force = None Bool
, force_basic_auth = None Bool
, group = None Text
, headers = None ../JSON.dhall
, http_agent = None Text
, method = None Text
, mode = None Text
, owner = None Text
, remote_src = None Bool
, removes = None Text
, return_content = None Bool
, selevel = None Text
, serole = None Text
, setype = None Text
, seuser = None Text
, src = None Text
, status_code = None (List Text)
, timeout = None Natural
, unix_socket = None Text
, unredirected_headers = None (List Text)
, unsafe_writes = None Bool
, url_password = None Text
, url_username = None Text
, use_gssapi = None Bool
, use_proxy = None Bool
, validate_certs = None Bool
}