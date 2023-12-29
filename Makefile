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

generate:
	xcodegen generate

setup_build_tools:
	sh scripts/setup_build_tools.sh

.PHONY: all bootstrap hook mint lint fmt generate setup_build_tools