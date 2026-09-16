---
code: DOT-83
id: 84
database_id: 709666169
node_id: MDU6SXNzdWU3MDk2NjYxNjk=
status: closed
title: "tools problem"
labels: ["help wanted","type: bug"]
url: https://github.com/kamilsk/dotfiles/issues/84
created_at: 2020-09-27T04:43:22Z
updated_at: 2026-09-17T11:15:12Z
---

# tools problem

Fix the Go toolset build, which failed while compiling a dependency of GoReleaser:

```
$ go generate tools.go
# github.com/goreleaser/nfpm/rpm
../../Development/go/pkg/mod/github.com/goreleaser/nfpm@v1.1.5/rpm/rpm.go:108:3: unknown field 'Summary' in struct literal of type rpmpack.RPMMetaData
tools.go:19: running "go": exit status 2
```

`nfpm` v1.1.5 was built against an older `rpmpack`; the module graph of the toolset resolved a newer `rpmpack` without that field, so `go install` of the whole tool list aborted at this package — one broken transitive dependency stopped every tool from being installed.

Expected: `go generate tools.go` installs all tools; a heavyweight program with a fragile dependency tree does not hold the rest hostage.
