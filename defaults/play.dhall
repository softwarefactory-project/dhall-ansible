{ vars = None ../types/map_text.dhall
, gather_facts = None Bool
, gather_subset = None (List Text)
, gather_timeout = None Natural
, fact_path = None Text
, vars_files = None (List Text)
, vars_prompt = None (List Text)
, roles = None (List Text)
, handlers = None (List Text)
, pre_tasks = None (List ../types/task.dhall)
, post_tasks = None (List ../types/task.dhall)
, tasks = None (List ../types/task.dhall)
, force_handlers = None Bool
, max_fail_percentage = None Double
, serial = None (List Text)
, strategy = None Text
, order = None Text
}
