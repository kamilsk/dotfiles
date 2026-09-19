---
code: DOT-15
id: MDU6SXNzdWU0NDA1NzUwMDg=
databaseId: 440575008
number: 15
url: https://github.com/kamilsk/dotfiles/issues/15
title: "problem with git refresh"
labels:
  - "type: bug"
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-05-06T07:32:57Z
updatedAt: 2026-09-17T10:58:26Z
lastEditedAt: 2026-09-17T10:58:26Z
closedAt: 2019-05-06T07:37:38Z
---

# problem with git refresh

Fix `git refresh` failing at the fetch step. The original error (the Russian git message means "fetch --all does not take a repository argument"):

```bash
$ git refresh
fatal: fetch --all не принимает имя репозитория как аргумент
done
```

Git rejects `git fetch --all <remote>`: `--all` and an explicit remote are mutually exclusive. The likely reading is that the early script passed the remote it had just resolved to a fetch that already carried `--all`, so every run died before the rebase, and the trailing `done` was printed regardless. Expected: `git refresh` fetches (all remotes, or the chosen one, not both) and then rebases; a failed fetch stops the command instead of reporting `done`.
