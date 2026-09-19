---
code: DOT-78
id: MDU6SXNzdWU2NTY4Mzc1ODc=
databaseId: 656837587
number: 79
url: https://github.com/kamilsk/dotfiles/issues/79
title: "bug with git cmm"
labels:
  - "type: bug"
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2020-07-14T19:12:44Z
updatedAt: 2026-09-17T11:14:46Z
lastEditedAt: 2026-09-17T11:14:46Z
closedAt: 2020-07-14T19:23:57Z
---

# bug with git cmm

Fix `git cmm` after a refactoring left the message words being passed as pathspecs:

```bash
$ git cmm update golangci-lint config
error: pathspec 'golangci-lint' did not match any file(s) known to git
error: pathspec 'config' did not match any file(s) known to git
```

`cmm` is meant to join every argument into the commit message ([[DOT-14]]). Here only the first word went into `-m` and the rest reached `git commit` as file arguments, so any multi-word message without quotes failed (or, worse, committed only the named paths if they existed).
