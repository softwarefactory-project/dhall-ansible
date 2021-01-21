{ state : Optional ./state.dhall
, update_cache : Optional Bool
, force : Optional Bool
, default_release : Optional Text
, upgrade : Optional ./upgrade.dhall
, only_upgrade : Optional Bool
, deb : Optional Text
, allow_unauthenticated : Optional Bool
, update_cache_retry_max_delay : Optional Natural
, name : Optional (List Text)
, cache_valid_time : Optional Text
, dpkg_options : Optional Text
, autoclean : Optional Bool
, policy_rc_d : Optional Natural
, purge : Optional Bool
, update_cache_retries : Optional Natural
, force_apt_get : Optional Bool
, install_recommends : Optional Bool
, autoremove : Optional Bool
}