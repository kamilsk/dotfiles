.DEFAULT_GOAL = install

AT    := @
SHELL := /bin/bash -euo pipefail

verbose:
	$(eval AT :=)
	$(eval MAKE := $(MAKE) verbose)
	@echo >/dev/null
.PHONY: verbose

todo:
	$(AT) grep \
		--exclude=Makefile \
		--exclude-dir={bin,components,node_modules,vendor} \
		--color \
		--text \
		-nRo -E ' TODO:.*|SkipNow' . || true
.PHONY: todo

install: install-git-blame
install: install-ngrok
install: install-spot
install: install-go-tools
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

install-ngrok: HASH = c/4VmDzA7iaHb
install-ngrok:
	$(AT) if ! command -v ngrok >/dev/null; then \
		curl -sSfL https://bin.equinox.io/$(HASH)/ngrok-stable-darwin-amd64.zip \
		     -o ngrok.zip; \
		unzip ngrok.zip; \
		chmod +x ngrok; \
		mv ngrok $(GOPATH)/bin/; \
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

install-go-tools:
	$(AT) cd toolset && go mod tidy && go generate -tags tools tools.go
.PHONY: install-go-tools
