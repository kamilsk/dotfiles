---
code: DOT-18
id: 18
database_id: 442134132
node_id: MDU6SXNzdWU0NDIxMzQxMzI=
status: closed
state_reason: completed
milestone:
title: "bug with git sync"
labels: ["type: bug"]
url: https://github.com/kamilsk/dotfiles/issues/18
created_at: 2019-05-09T09:17:07Z
updated_at: 2026-09-17T10:59:45Z
---

# bug with git sync

Fix `git sync`, the helper that walks every git repository under the current directory and pulls each one, which broke on a stray `#`. The original output:

```
Current branch master is up to date.
/Users/.../.dotfiles/bin/git_sync: line 11:  #: command not found
```

Bash reports `#: command not found` when a `#` lands in command position — typically a comment placed after a line continuation or inside a command list — so the pull itself succeeded and the "command" after it failed. Expected: the script processes each repository with no output beyond git's own, and a slip like this is caught by shellcheck rather than at run time.
