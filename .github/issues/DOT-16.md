---
code: DOT-16
id: 16
database_id: 441028343
node_id: MDU6SXNzdWU0NDEwMjgzNDM=
status: closed
title: "extend git refresh"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/16
created_at: 2019-05-07T05:01:36Z
updated_at: 2026-09-17T10:58:52Z
---

# extend git refresh

Let `git refresh` take the remote to rebase onto, so that a fork can be brought up to date with its `upstream` and not only with the tracked remote. The original sketch:

```bash
$ git refresh upstream
# -> git fetch --all --prune...
# -> find git remote
# -> define its default branch
# -> git rebase upstream/default
```

Expected: `git refresh upstream` fetches, resolves the default branch of `upstream` and rebases the current branch onto it; an unknown remote name is refused; with no argument the behaviour of [#5](DOT-5.md) stays.
