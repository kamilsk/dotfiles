---
code: DOT-46
id: MDU6SXNzdWU0NjkxOTg2NTM=
databaseId: 469198653
number: 47
url: https://github.com/kamilsk/dotfiles/issues/47
title: "extend coverall"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-07-17T13:37:21Z
updatedAt: 2026-09-17T11:11:06Z
lastEditedAt: 2026-09-17T11:11:06Z
closedAt: 2019-07-21T06:45:01Z
---

# extend coverall

Extend `coverall` ([[DOT-44]]) with a per-function coverage report. The per-package percentages hide which functions are untested; `go tool cover -func` over a coverage profile lists every function with its coverage. The original sketch, a function the author had elsewhere:

```
cover () {
    local t=$(mktemp -t cover)
    go test $COVERFLAGS -coverprofile=$t $@ \
        && go tool cover -func=$t \
        && unlink $t
}
```

Applied to `coverall`, this means writing a profile for each package, merging them into one, and running `go tool cover -func` on the merged file; extra flags come from the arguments or an environment variable such as `COVERFLAGS`.
