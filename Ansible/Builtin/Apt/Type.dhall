{ upgrade : Optional ./upgrade.dhall
, update_cache_retry_max_delay : Optional Natural
, update_cache_retries : Optional Natural
, update_cache : Optional Bool
, state : Optional ./state.dhall
, purge : Optional Bool
, policy_rc_d : Optional Natural
, only_upgrade : Optional Bool
, name : Optional (List Text)
, install_recommends : Optional Bool
, force_apt_get : Optional Bool
, force : Optional Bool
, dpkg_options : Optional Text
, default_release : Optional Text
, deb : Optional Text
, cache_valid_time : Optional Text
, autoremove : Optional Bool
, autoclean : Optional Bool
, allow_unauthenticated : Optional Bool
}