---
code: DOT-53
id: 54
database_id: 485330695
node_id: MDU6SXNzdWU0ODUzMzA2OTU=
status: closed
title: "support php and python by coverall"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/54
created_at: 2019-08-26T16:44:11Z
updated_at: 2019-08-26T16:45:28Z
---

# support php and python by coverall

Make `coverall` ([#45](DOT-44.md)) useful outside Go: detect a PHP or Python project and run its coverage tool with the same interface, instead of hard-coding `go test`. The one-line body, "pass `$@` to `go test -cover`", records the other half of the change: the extra arguments the user gives should reach the underlying test command in every language branch.

The expected behaviour is that in a directory with `go.mod`, `composer.json` or `requirements.txt` the same `coverall [flags]` prints a coverage summary produced by the matching tool, and the flags are forwarded as separate words.
