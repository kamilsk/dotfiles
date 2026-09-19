---
code: DOT-18
id: MDU6SXNzdWU0NDIxMzQxMzI=
databaseId: 442134132
number: 18
url: https://github.com/kamilsk/dotfiles/issues/18
title: "bug with git sync"
labels:
  - "type: bug"
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-05-09T09:17:07Z
updatedAt: 2026-09-17T10:59:45Z
lastEditedAt: 2026-09-17T10:59:45Z
closedAt: 2019-05-09T11:58:49Z
---

# bug with git sync

Fix `git sync`, the helper that walks every git repository under the current directory and pulls each one, which broke on a stray `#`. The original output:

```
Current branch master is up to date.
/Users/.../.dotfiles/bin/git_sync: line 11:  #: command not found
```

Bash reports `#: command not found` when a `#` lands in command position — typically a comment placed after a line continuation or inside a command list — so the pull itself succeeded and the "command" after it failed. Expected: the script processes each repository with no output beyond git's own, and a slip like this is caught by shellcheck rather than at run time.
