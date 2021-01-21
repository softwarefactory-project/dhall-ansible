{ cron_file = None Text
, reboot = None Bool
, minute = None Text
, insertafter = None Text
, weekday = None Text
, month = None Text
, hour = None Text
, job = None Text
, name = None Text
, day = None Text
, user = None Text
, backup = None Bool
, insertbefore = None Text
, special_time = None ./special_time.dhall
, disabled = None Bool
, env = None Bool
, state = None ./state.dhall
}