---
code: DOT-98
id: 99
database_id: 787540100
node_id: MDU6SXNzdWU3ODc1NDAxMDA=
status: closed
title: "research benefits to combine all git_* scripts into one Go binary"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/99
created_at: 2021-01-16T19:51:20Z
updated_at: 2021-02-26T18:30:23Z
---

# research benefits to combine all git_* scripts into one Go binary

Evaluate rewriting the collection of `git_*` shell scripts ([git_current](../../bin/git_current), [git_refresh](../../bin/git_refresh), [git_shake](../../bin/git_shake), …) as a single Go program. Candidate libraries: [git2go](https://github.com/libgit2/git2go) (libgit2 bindings) or the pure-Go [go-git](https://github.com/go-git/go-git); [go-pear](https://github.com/derekparker/go-pear) as an example of a small git helper in Go. The expected gains are testability, portability off macOS/bash and no dependence on parsing porcelain output.
