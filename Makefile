all: update lint test

test:
	@dhall-to-yaml --omit-empty --explain --file examples/demo.dhall

update:
	@python3 scripts/update.py

lint:
	@bash -c 'for f in $$(find . -name "*.dhall"); do dhall format --ascii < $$f > $$f.fmt; mv $$f.fmt $$f; done'
