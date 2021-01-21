{ allow_unauthenticated : Optional Bool
, autoclean : Optional Bool
, autoremove : Optional Bool
, cache_valid_time : Optional Text
, deb : Optional Text
, default_release : Optional Text
, dpkg_options : Optional Text
, force : Optional Bool
, force_apt_get : Optional Bool
, install_recommends : Optional Bool
, name : Optional (List Text)
, only_upgrade : Optional Bool
, policy_rc_d : Optional Natural
, purge : Optional Bool
, state : Optional ./state.dhall
, update_cache : Optional Bool
, update_cache_retries : Optional Natural
, update_cache_retry_max_delay : Optional Natural
, upgrade : Optional ./upgrade.dhall
}