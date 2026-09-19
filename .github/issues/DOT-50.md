---
code: DOT-50
id: MDU6SXNzdWU0ODE0ODgyMjE=
databaseId: 481488221
number: 51
url: https://github.com/kamilsk/dotfiles/issues/51
title: "go checks"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-08-16T07:49:32Z
updatedAt: 2026-09-17T11:11:45Z
lastEditedAt: 2026-09-17T11:11:45Z
closedAt: 2019-09-14T07:08:10Z
---

# go checks

Collect the small CI check scripts used by Go projects so that they are available from the dotfiles rather than copied into every repository. The four scripts in the issue are taken from the [golang/mock `ci` directory](https://github.com/golang/mock/tree/master/ci) and the author's own variant of the first one:

- `check-go-mod.sh` — run `go mod tidy -v` and fail when its output mentions `unused` requirements;
- `check_go_fmt.sh` — fail with a diff when any `.go` file is not `gofmt`-formatted;
- `check_go_generate.sh` — copy the tree, run `go generate ./...` and fail when `diff -r` shows that generated files were stale (with the note that locally it updates the files as a side effect, which suits a fresh CI checkout better than development);
- `check_go_mod.sh` — run `go mod tidy` and fail when `git status --porcelain` shows a modified `go.mod`.

The useful outcome for this setup is a single place (a script or a set of functions on `PATH`) that runs these checks in any Go project, with the same exit-code semantics as in CI, so that a push does not fail on formatting, a stale `go.mod` or forgotten `go generate`.

<!-- 2019-09-14T07:08Z https://github.com/kamilsk/dotfiles/issues/51#issuecomment-531456424
won't do
-->
