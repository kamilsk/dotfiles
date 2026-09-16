---
code: DOT-78
id: 79
database_id: 656837587
node_id: MDU6SXNzdWU2NTY4Mzc1ODc=
status: closed
title: "bug with git cmm"
labels: ["type: bug"]
url: https://github.com/kamilsk/dotfiles/issues/79
created_at: 2020-07-14T19:12:44Z
updated_at: 2022-08-14T18:59:27Z
---

# bug with git cmm

Fix `git cmm` after a refactoring left the message words being passed as pathspecs:

```bash
$ git cmm update golangci-lint config
error: pathspec 'golangci-lint' did not match any file(s) known to git
error: pathspec 'config' did not match any file(s) known to git
```

`cmm` is meant to join every argument into the commit message ([#14](DOT-14.md)). Here only the first word went into `-m` and the rest reached `git commit` as file arguments, so any multi-word message without quotes failed (or, worse, committed only the named paths if they existed).
