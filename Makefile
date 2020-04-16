all: update lint freeze test doc

test:
	@bash -c 'for f in $$(find tests/ -name "*.yaml"); do yaml-to-dhall "List (./package.dhall).Play.Type" < $$f > /dev/null; done'

update:
	@python3 scripts/update.py

generate: do-generate lint

do-generate:
	@python3 scripts/generate.py

freeze:
	@dhall freeze --inplace ./package.dhall --all

lint:
	@bash -c 'for f in $$(find . -name "*.dhall"); do dhall format --ascii < $$f > $$f.fmt; mv $$f.fmt $$f; done'

doc:
	@python3 scripts/doc.py
