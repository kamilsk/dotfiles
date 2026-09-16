---
code: DOT-46
id: 47
database_id: 469198653
node_id: MDU6SXNzdWU0NjkxOTg2NTM=
status: closed
title: "extend coverall"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/47
created_at: 2019-07-17T13:37:21Z
updated_at: 2026-09-17T11:11:06Z
---

# extend coverall

Extend `coverall` ([#45](DOT-44.md)) with a per-function coverage report. The per-package percentages hide which functions are untested; `go tool cover -func` over a coverage profile lists every function with its coverage. The original sketch, a function the author had elsewhere:

```
cover () {
    local t=$(mktemp -t cover)
    go test $COVERFLAGS -coverprofile=$t $@ \
        && go tool cover -func=$t \
        && unlink $t
}
```

Applied to `coverall`, this means writing a profile for each package, merging them into one, and running `go tool cover -func` on the merged file; extra flags come from the arguments or an environment variable such as `COVERFLAGS`.
