{ async = None Bool
, attributes = None Text
, bandwidth = None Text
, baseurl = None (List Text)
, cost = None Text
, deltarpm_metadata_percentage = None Text
, deltarpm_percentage = None Text
, description = None Text
, enabled = None Bool
, enablegroups = None Bool
, exclude = None (List Text)
, failovermethod = None ./failovermethod.dhall
, file = None Text
, gpgcakey = None Text
, gpgcheck = None Bool
, gpgkey = None (List Text)
, group = None Text
, http_caching = None ./http_caching.dhall
, include = None Text
, includepkgs = None (List Text)
, ip_resolve = None ./ip_resolve.dhall
, keepalive = None Bool
, keepcache = None ./keepcache.dhall
, metadata_expire = None Text
, metadata_expire_filter = None ./metadata_expire_filter.dhall
, metalink = None Text
, mirrorlist = None Text
, mirrorlist_expire = None Text
, mode = None Text
, module_hotfixes = None Bool
, owner = None Text
, password = None Text
, priority = None Text
, protect = None Bool
, proxy = None Text
, proxy_password = None Text
, proxy_username = None Text
, repo_gpgcheck = None Bool
, reposdir = None Text
, retries = None Text
, s3_enabled = None Bool
, selevel = None Text
, serole = None Text
, setype = None Text
, seuser = None Text
, skip_if_unavailable = None Bool
, ssl_check_cert_permissions = None Bool
, sslcacert = None Text
, sslclientcert = None Text
, sslclientkey = None Text
, sslverify = None Bool
, state = None ./state.dhall
, throttle = None Text
, timeout = None Text
, ui_repoid_vars = None Text
, unsafe_writes = None Bool
, username = None Text
}