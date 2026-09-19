---
code: DOT-27
id: MDU6SXNzdWU0NDUzODk1MDA=
databaseId: 445389500
number: 27
url: https://github.com/kamilsk/dotfiles/issues/27
title: "git refresh not work on master branch"
labels:
  - "type: bug"
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-05-17T11:08:15Z
updatedAt: 2026-09-17T11:03:42Z
lastEditedAt: 2026-09-17T11:03:42Z
closedAt: 2019-06-17T20:22:27Z
---

# git refresh not work on master branch

Make `git refresh <remote>` actually update the default branch when it is the one checked out. The original transcript:

```bash
$ master> git refresh upstream
Current branch master is up to date.
$ master> git diff upstream/master..
...has changes
```

`git diff upstream/master..` shows what the local branch has that `upstream/master` lacks, so the transcript is consistent with `master` being ahead of upstream (then the rebase is right to say "up to date") as much as with a fetch that did not refresh `upstream/master`; the author read it as a bug, presumably expecting the local trunk to end up equal to upstream's. Expected: on the default branch, `git refresh upstream` results in a branch that contains `upstream/master`, and the message reflects what actually happened.
