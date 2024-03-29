{ async : Optional Bool
, attributes : Optional Text
, bandwidth : Optional Text
, baseurl : Optional (List Text)
, cost : Optional Text
, deltarpm_metadata_percentage : Optional Text
, deltarpm_percentage : Optional Text
, description : Optional Text
, enabled : Optional Bool
, enablegroups : Optional Bool
, exclude : Optional (List Text)
, failovermethod : Optional ./failovermethod.dhall
, file : Optional Text
, gpgcakey : Optional Text
, gpgcheck : Optional Bool
, gpgkey : Optional (List Text)
, group : Optional Text
, http_caching : Optional ./http_caching.dhall
, include : Optional Text
, includepkgs : Optional (List Text)
, ip_resolve : Optional ./ip_resolve.dhall
, keepalive : Optional Bool
, keepcache : Optional ./keepcache.dhall
, metadata_expire : Optional Text
, metadata_expire_filter : Optional ./metadata_expire_filter.dhall
, metalink : Optional Text
, mirrorlist : Optional Text
, mirrorlist_expire : Optional Text
, mode : Optional Text
, module_hotfixes : Optional Bool
, name : Text
, owner : Optional Text
, password : Optional Text
, priority : Optional Text
, protect : Optional Bool
, proxy : Optional Text
, proxy_password : Optional Text
, proxy_username : Optional Text
, repo_gpgcheck : Optional Bool
, reposdir : Optional Text
, retries : Optional Text
, s3_enabled : Optional Bool
, selevel : Optional Text
, serole : Optional Text
, setype : Optional Text
, seuser : Optional Text
, skip_if_unavailable : Optional Bool
, ssl_check_cert_permissions : Optional Bool
, sslcacert : Optional Text
, sslclientcert : Optional Text
, sslclientkey : Optional Text
, sslverify : Optional Bool
, state : Optional ./state.dhall
, throttle : Optional Text
, timeout : Optional Text
, ui_repoid_vars : Optional Text
, unsafe_writes : Optional Bool
, username : Optional Text
}