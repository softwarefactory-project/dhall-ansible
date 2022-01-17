{ allow_downgrade : Optional Bool
, allow_unauthenticated : Optional Bool
, autoclean : Optional Bool
, autoremove : Optional Bool
, cache_valid_time : Optional Natural
, deb : Optional Text
, default_release : Optional Text
, dpkg_options : Optional Text
, fail_on_autoremove : Optional Bool
, force : Optional Bool
, force_apt_get : Optional Bool
, install_recommends : Optional Bool
, lock_timeout : Optional Natural
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