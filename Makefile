.DEFAULT_GOAL = install-spot
SHELL         = /bin/bash -euo pipefail

install-spot: LATEST = '"5a7c385c1fc7611ed3c7b8691438214c1956746c"'
install-spot:
	@if [ `gh api repos/rauchg/spot/commits | jq '.[0].sha'` != $(LATEST) ]; then \
		curl -sSfL https://raw.github.com/rauchg/spot/master/spot.sh -o bin/spot && chmod +x bin/spot; \
	fi
.PHONY: install-spot
