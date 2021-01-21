{ validate_certs : Optional Bool
, use_backend : Optional ./use_backend.dhall
, update_only : Optional Bool
, update_cache : Optional Bool
, state : Optional ./state.dhall
, skip_broken : Optional Bool
, security : Optional Bool
, releasever : Optional Text
, name : Optional (List Text)
, lock_timeout : Optional Natural
, list : Optional Text
, installroot : Optional Text
, install_weak_deps : Optional Bool
, install_repoquery : Optional Bool
, exclude : Optional Text
, enablerepo : Optional Text
, enable_plugin : Optional Text
, download_only : Optional Bool
, download_dir : Optional Text
, disablerepo : Optional Text
, disable_plugin : Optional Text
, disable_gpg_check : Optional Bool
, disable_excludes : Optional Text
, conf_file : Optional Text
, bugfix : Optional Text
, autoremove : Optional Bool
, allow_downgrade : Optional Bool
}