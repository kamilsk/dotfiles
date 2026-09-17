---
code: DOT-80
id: 81
database_id: 665375446
node_id: MDU6SXNzdWU2NjUzNzU0NDY=
status: closed
state_reason: completed
milestone:
title: "/bin/bash: looppointer: command not found"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/81
created_at: 2020-07-24T19:38:55Z
updated_at: 2026-09-17T11:14:53Z
---

# /bin/bash: looppointer: command not found

Fix the Go toolset build failing on `looppointer`. The one-line diagnosis, "problem with modules", refers to `go generate tools.go` trying to run — or install — [kyoh86/looppointer](https://github.com/kyoh86/looppointer), a linter for loop-variable pointer bugs, and the binary not being found; typically the module path in `tools.go` did not match the package's `main` (the linter's command lives in a `cmd/` subdirectory), so `go install` built a library and produced no executable.
