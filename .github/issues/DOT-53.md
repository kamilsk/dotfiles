---
code: DOT-53
id: MDU6SXNzdWU0ODUzMzA2OTU=
databaseId: 485330695
number: 54
url: https://github.com/kamilsk/dotfiles/issues/54
title: "support php and python by coverall"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-08-26T16:44:11Z
updatedAt: 2026-09-17T11:12:14Z
lastEditedAt: 2026-09-17T11:12:14Z
closedAt: 2019-08-26T16:45:28Z
---

# support php and python by coverall

Make `coverall` ([[DOT-44]]) useful outside Go: detect a PHP or Python project and run its coverage tool with the same interface, instead of hard-coding `go test`. The one-line body, "pass `$@` to `go test -cover`", records the other half of the change: the extra arguments the user gives should reach the underlying test command in every language branch.

The expected behaviour is that in a directory with `go.mod`, `composer.json` or `requirements.txt` the same `coverall [flags]` prints a coverage summary produced by the matching tool, and the flags are forwarded as separate words.
