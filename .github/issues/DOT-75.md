---
code: DOT-75
id: 76
database_id: 613471075
node_id: MDU6SXNzdWU2MTM0NzEwNzU=
status: closed
title: "download goreleaser tools not from go mod"
labels: ["help wanted"]
url: https://github.com/kamilsk/dotfiles/issues/76
created_at: 2020-05-06T16:59:52Z
updated_at: 2020-05-24T06:37:15Z
---

# download goreleaser tools not from go mod

Stop building heavyweight Go programs through the `toolset` module and install their released binaries instead. Candidates:

```
- hugo
- goreleaser
- golangci-lint
- egg
```

Each of these drags a large dependency graph into `toolset/go.mod`; a single incompatible transitive module breaks `go generate tools.go` for every tool at once — the `nfpm`/`rpmpack` failure in [#84](DOT-83.md) is the concrete case. They also ship signed release binaries, so building them locally buys nothing. `egg` is the author's own generator ([kamilsk/egg](https://github.com/kamilsk/egg)), which is what produces [tools.go](../../toolset/tools.go).
