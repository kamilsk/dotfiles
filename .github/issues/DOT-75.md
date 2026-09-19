---
code: DOT-75
id: MDU6SXNzdWU2MTM0NzEwNzU=
databaseId: 613471075
number: 76
url: https://github.com/kamilsk/dotfiles/issues/76
title: "download goreleaser tools not from go mod"
labels:
  - "help wanted"
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2020-05-06T16:59:52Z
updatedAt: 2026-09-17T11:14:36Z
lastEditedAt: 2026-09-17T11:14:36Z
closedAt: 2020-05-24T06:37:15Z
---

# download goreleaser tools not from go mod

Stop building heavyweight Go programs through the `toolset` module and install their released binaries instead. Candidates:

```
- hugo
- goreleaser
- golangci-lint
- egg
```

Each of these drags a large dependency graph into `toolset/go.mod`; a single incompatible transitive module breaks `go generate tools.go` for every tool at once — the `nfpm`/`rpmpack` failure in [[DOT-83]] is the concrete case. They also ship signed release binaries, so building them locally buys nothing. `egg` is the author's own generator ([kamilsk/egg](https://github.com/kamilsk/egg)), which is what produces [tools.go](../../toolset/tools.go).
