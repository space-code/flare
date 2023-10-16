all: bootstrap

bootstrap: hook brew
	mint bootstrap

hook:
	ln -sf ../../hooks/pre-commit .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit

brew:
	brew bundle check || brew bundle

mint:
	mint bootstrap

lint:
	mint run swiftlint

fmt:
	mint run swiftformat Sources Tests

.PHONY: all bootstrap hook mint lint fmt