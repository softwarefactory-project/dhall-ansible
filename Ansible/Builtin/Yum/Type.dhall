{ allow_downgrade : Optional Bool
, autoremove : Optional Bool
, bugfix : Optional Text
, conf_file : Optional Text
, disable_excludes : Optional Text
, disable_gpg_check : Optional Bool
, disable_plugin : Optional Text
, disablerepo : Optional Text
, download_dir : Optional Text
, download_only : Optional Bool
, enable_plugin : Optional Text
, enablerepo : Optional Text
, exclude : Optional Text
, install_repoquery : Optional Bool
, install_weak_deps : Optional Bool
, installroot : Optional Text
, list : Optional Text
, lock_timeout : Optional Natural
, name : Optional (List Text)
, releasever : Optional Text
, security : Optional Bool
, skip_broken : Optional Bool
, state : Optional ./state.dhall
, update_cache : Optional Bool
, update_only : Optional Bool
, use_backend : Optional ./use_backend.dhall
, validate_certs : Optional Bool
}