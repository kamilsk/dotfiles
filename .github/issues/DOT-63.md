---
code: DOT-63
id: MDU6SXNzdWU1MTM3MTE3MjY=
databaseId: 513711726
number: 64
url: https://github.com/kamilsk/dotfiles/issues/64
title: "realpath alias"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-10-29T06:04:35Z
updatedAt: 2026-09-17T11:13:40Z
lastEditedAt: 2026-09-17T11:13:40Z
closedAt: 2019-11-17T11:19:27Z
---

# realpath alias

Add a `realpath` helper that turns a relative file or directory name into an absolute path, wrapping the idiom the author kept retyping in scripts:

```bash
$(cd `dirname ${0}` && pwd)
```

At the time macOS shipped no `realpath` binary (it arrived with macOS 13, and otherwise comes from GNU coreutils), so scripts that need their own directory, or an absolute path to pass to another tool, each carried this `cd`/`pwd` dance. The expected behaviour is `realpath <path>` printing the absolute path, resolving through the shell rather than requiring an extra tool.
