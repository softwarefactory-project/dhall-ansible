all: update lint freeze test doc

test:
	@dhall-to-yaml --explain --file examples/demo.dhall > /dev/null

update:
	@python3 scripts/update.py

freeze:
	@dhall freeze --inplace ./package.dhall --all

lint:
	@bash -c 'for f in $$(find . -name "*.dhall"); do dhall format --ascii < $$f > $$f.fmt; mv $$f.fmt $$f; done'

doc:
	@python3 scripts/doc.py
