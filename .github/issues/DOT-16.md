---
code: DOT-16
id: MDU6SXNzdWU0NDEwMjgzNDM=
databaseId: 441028343
number: 16
url: https://github.com/kamilsk/dotfiles/issues/16
title: "extend git refresh"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-05-07T05:01:36Z
updatedAt: 2026-09-17T10:58:52Z
lastEditedAt: 2026-09-17T10:58:52Z
closedAt: 2019-05-07T09:25:18Z
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

Expected: `git refresh upstream` fetches, resolves the default branch of `upstream` and rebases the current branch onto it; an unknown remote name is refused; with no argument the behaviour of [[DOT-5]] stays.
