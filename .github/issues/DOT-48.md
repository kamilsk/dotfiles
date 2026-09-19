---
code: DOT-48
id: MDU6SXNzdWU0NzY1NTg5NDU=
databaseId: 476558945
number: 49
url: https://github.com/kamilsk/dotfiles/issues/49
title: "fzqurl"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-08-04T14:24:19Z
updatedAt: 2026-09-17T11:11:25Z
lastEditedAt: 2026-09-17T11:11:25Z
closedAt: 2019-08-04T14:30:19Z
---

# fzqurl

Add a `fzqurl` helper that combines `curl`, `rq` and `fzf`: fetch a JSON document from a URL, reshape it with `rq` (a record-query tool for JSON/YAML/TOML) and pick an entry interactively with the `fzf` fuzzy finder. The original example is the GitHub tags API of the author's `retry` library:

```bash
fzqurl https://api.github.com/repos/kamilsk/retry/tags
```

The presumable outcome is choosing a tag (or any element of an array response) from a fuzzy list and printing the chosen value, so that a version can be selected in a script or pasted into a `go get` without leaving the terminal. How the `rq` expression is supplied and what is printed were not specified — the issue was opened and closed within minutes and reads as a noted idea.
