---
code: DOT-92
id: 93
database_id: 777612169
node_id: MDU6SXNzdWU3Nzc2MTIxNjk=
status: closed
state_reason: completed
milestone:
title: "git state"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/93
created_at: 2021-01-03T10:34:43Z
updated_at: 2026-09-17T11:15:46Z
---

# git state

Add `git state`, a one-screen summary of where a repository stands:

```bash
$ git state
# git status
# git stash list
```

`git status` alone hides the stash; the author's `pull` stashes and pops automatically ([[DOT-189]]), so forgotten stash entries are a real risk, and seeing them next to the status is the point. Later requests extended the same screen with the remotes ([[DOT-132]]) and the latest release ([[DOT-126]]).
