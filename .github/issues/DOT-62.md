---
code: DOT-62
id: 63
database_id: 513705090
node_id: MDU6SXNzdWU1MTM3MDUwOTA=
status: closed
title: "activate alias"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/63
created_at: 2019-10-29T05:41:35Z
updated_at: 2026-09-17T11:13:31Z
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
