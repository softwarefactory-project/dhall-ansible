all: update test

test:
	@(dhall-to-yaml --omitEmpty --explain --file examples/demo.dhall)

update:
	@(python3 scripts/update.py)
