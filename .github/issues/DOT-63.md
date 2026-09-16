---
code: DOT-63
id: 64
database_id: 513711726
node_id: MDU6SXNzdWU1MTM3MTE3MjY=
status: closed
title: "realpath alias"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/64
created_at: 2019-10-29T06:04:35Z
updated_at: 2019-11-17T11:19:27Z
---

# realpath alias

Add a `realpath` helper that turns a relative file or directory name into an absolute path, wrapping the idiom the author kept retyping in scripts:

```bash
$(cd `dirname ${0}` && pwd)
```

At the time macOS shipped no `realpath` binary (it arrived with macOS 13, and otherwise comes from GNU coreutils), so scripts that need their own directory, or an absolute path to pass to another tool, each carried this `cd`/`pwd` dance. The expected behaviour is `realpath <path>` printing the absolute path, resolving through the shell rather than requiring an extra tool.
