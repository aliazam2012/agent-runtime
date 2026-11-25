# Every target runs through uv, so the lockfile decides every version.
UV ?= uv
SRC_DIRS := $(wildcard packages/*/src services/*/src)
EMPTY :=
SPACE := $(EMPTY) $(EMPTY)
MYPYPATH := $(subst $(SPACE),:,$(SRC_DIRS))

.PHONY: setup check lint types test purity audit

setup:
	$(UV) sync --all-packages

check: lint types test

lint:
	$(UV) run --all-packages ruff check .
	$(UV) run --all-packages ruff format --check .

types:
	# Every package directory by path: `-p freight_agents` sees only the first
	# directory of a namespace package spread over several source roots.
	MYPYPATH=$(MYPYPATH) $(UV) run --all-packages mypy $(addsuffix /freight_agents,$(SRC_DIRS))

test:
	$(UV) run --all-packages pytest

purity:
	$(UV) run --all-packages freight-purity .
	$(UV) run --all-packages freight-links .

# Audit the locked third-party dependencies (workspace packages excluded).
audit:
	$(UV) export --all-packages --no-emit-workspace --format requirements-txt -q -o .audit-requirements.txt
	$(UV) tool run --python 3.12 pip-audit==2.9.0 -r .audit-requirements.txt --no-deps --disable-pip --progress-spinner off
	rm -f .audit-requirements.txt

