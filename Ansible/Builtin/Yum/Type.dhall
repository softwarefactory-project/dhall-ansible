{ disablerepo : Optional Text
, install_repoquery : Optional Bool
, lock_timeout : Optional Natural
, download_only : Optional Bool
, bugfix : Optional Text
, state : Optional ./state.dhall
, validate_certs : Optional Bool
, disable_gpg_check : Optional Bool
, list : Optional Text
, update_cache : Optional Bool
, releasever : Optional Text
, disable_excludes : Optional Text
, download_dir : Optional Text
, name : Optional (List Text)
, enable_plugin : Optional Text
, installroot : Optional Text
, update_only : Optional Bool
, disable_plugin : Optional Text
, conf_file : Optional Text
, use_backend : Optional ./use_backend.dhall
, install_weak_deps : Optional Bool
, exclude : Optional Text
, security : Optional Bool
, skip_broken : Optional Bool
, autoremove : Optional Bool
, allow_downgrade : Optional Bool
, enablerepo : Optional Text
}