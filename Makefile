.DEFAULT_GOAL = install

AT    := @
ARCH  := $(shell uname -m | tr '[:upper:]' '[:lower:]')
OS    := $(shell uname -s | tr '[:upper:]' '[:lower:]')
DATE  := $(shell date +%Y-%m-%dT%T%Z)
SHELL := /usr/bin/env bash -euo pipefail -c

install: install-git-blame
install: install-go-tools
install: install-ngrok
install: install-spot
.PHONY: install

install-git-blame: LATEST = '"8d854c2d78cb98afdb9f5a73240e06393260b327"'
install-git-blame:
	$(AT) if [ `gh api repos/jayphelps/git-blame-someone-else/commits | jq '.[0].sha'` != $(LATEST) ]; then \
		curl -sSfL https://raw.github.com/jayphelps/git-blame-someone-else/master/git-blame-someone-else \
		     -o bin/gbse; \
		chmod +x bin/gbse; \
		git config --global alias.blame-someone-else "!gbse"; \
	fi
.PHONY: install-git-blame

install-go-tools:
	$(AT) cd toolset && go generate -mod=readonly -tags tools tools.go
.PHONY: install-go-tools

install-ngrok: HASH = c/bNyj1mQVY4c
install-ngrok:
	$(AT) if ! command -v ngrok >/dev/null; then \
		curl -sSfL https://bin.equinox.io/$(HASH)/ngrok-stable-darwin-amd64.zip \
		     -o ngrok.zip; \
		unzip ngrok.zip; \
		chmod +x ngrok; \
		mv ngrok $$(go env GOPATH)/bin/; \
		rm -f ngrok.zip; \
	fi
.PHONY: install-ngrok

install-spot: LATEST = '"5a7c385c1fc7611ed3c7b8691438214c1956746c"'
install-spot:
	$(AT) if [ `gh api repos/rauchg/spot/commits | jq '.[0].sha'` != $(LATEST) ]; then \
		curl -sSfL https://raw.github.com/rauchg/spot/master/spot.sh \
		     -o bin/spot; \
		chmod +x bin/spot; \
	fi
.PHONY: install-spot

todo:
	$(AT) grep \
		--exclude=Makefile \
		--exclude-dir={./test/bats,./test/helper} \
		--color \
		--text \
		-inRo -E 'TODO:.*' . || true
.PHONY: todo

verbose:
	$(eval AT :=) $(eval MAKE := $(MAKE) verbose) @true
.PHONY: verbose
