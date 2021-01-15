.DEFAULT_GOAL = install-spot
SHELL         = /bin/bash -euo pipefail

install-git-blame: LATEST = '"8d854c2d78cb98afdb9f5a73240e06393260b327"'
install-git-blame:
	@if [ `gh api repos/jayphelps/git-blame-someone-else/commits | jq '.[0].sha'` != $(LATEST) ]; then \
		curl -sSfL https://raw.github.com/jayphelps/git-blame-someone-else/master/git-blame-someone-else \
			-o bin/gbse \
			&& chmod +x bin/gbse; \
		git config --global alias.blame-someone-else "!gbse"; \
	fi
.PHONY: install-git-blame

install-spot: LATEST = '"5a7c385c1fc7611ed3c7b8691438214c1956746c"'
install-spot:
	@if [ `gh api repos/rauchg/spot/commits | jq '.[0].sha'` != $(LATEST) ]; then \
		curl -sSfL https://raw.github.com/rauchg/spot/master/spot.sh \
		-o bin/spot \
		&& chmod +x bin/spot; \
	fi
.PHONY: install-spot

install-go-tools:
	@cd toolset && go mod tidy && go generate -tags tools tools.go
.PHONY: install-go-tools
