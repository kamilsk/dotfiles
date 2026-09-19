---
code: DOT-62
id: MDU6SXNzdWU1MTM3MDUwOTA=
databaseId: 513705090
number: 63
url: https://github.com/kamilsk/dotfiles/issues/63
title: "activate alias"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-10-29T05:41:35Z
updatedAt: 2026-09-17T11:13:31Z
lastEditedAt: 2026-09-17T11:13:31Z
closedAt: 2019-11-19T20:58:13Z
---

# activate alias

Add an `activate` helper that finds the virtual-environment activation script of the current project and sources it, so that entering a Python (or similar) project does not require remembering where its environment lives. The original sketch:

```bash
$ activate
# source bin/activate
# source env/activate
# find activate and use it
```

The expected behaviour is to try the known locations in order and source the first one found; with nothing found, say so and fail rather than silently do nothing. It has to be a function, not a script, because `source` must affect the caller's shell.
