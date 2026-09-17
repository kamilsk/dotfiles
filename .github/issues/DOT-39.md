---
code: DOT-39
id: 40
database_id: 461919736
node_id: MDU6SXNzdWU0NjE5MTk3MzY=
status: closed
state_reason: completed
milestone:
title: "add lookup alias"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/40
created_at: 2019-06-28T08:28:44Z
updated_at: 2026-09-17T11:09:23Z
---

# add lookup alias

Add a `lookup <name>` helper that shows what a command is: for a script on `PATH` print its source, otherwise report what kind of thing it is. The trigger was the `stash` prototype ([[DOT-37]]) — reading it required `cat $(which stash)` every time:

```bash
$ lookup stash
-> cat `which stash` or check that is file
```

The expected behaviour is a single command that resolves a name the way the shell would (`command -v`), and then does the useful thing per kind: shell scripts are printed, other text is paged, binaries are only identified, and things that are not files (aliases, functions, builtins) are described rather than reported as "not found".
