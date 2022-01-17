{ allow_downgrade : Optional Bool
, autoremove : Optional Bool
, bugfix : Optional Bool
, cacheonly : Optional Bool
, conf_file : Optional Text
, disable_excludes : Optional Text
, disable_gpg_check : Optional Bool
, disable_plugin : Optional (List Text)
, disablerepo : Optional (List Text)
, download_dir : Optional Text
, download_only : Optional Bool
, enable_plugin : Optional (List Text)
, enablerepo : Optional (List Text)
, exclude : Optional (List Text)
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