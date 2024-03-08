CHILD_MAKEFILES_DIRS = $(sort $(dir $(wildcard Sources/*/Makefile)))

all: bootstrap

bootstrap: hook
	mint bootstrap

hook:
	ln -sf ../../hooks/pre-commit .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit

mint:
	mint bootstrap

lint:
	mint run swiftlint

fmt:
	mint run swiftformat Sources Tests

swiftgen:
	@for d in $(CHILD_MAKEFILES_DIRS); do ( cd $$d && make swiftgen; ); done

generate:
	xcodegen generate

setup_build_tools:
	sh scripts/setup_build_tools.sh

build:
	swift build -c release --target Flare

test:
	xcodebuild test -scheme "Flare" -destination "$(destination)" -testPlan AllTests clean -enableCodeCoverage YES

.PHONY: all bootstrap hook mint lint fmt generate setup_build_tools strings build test