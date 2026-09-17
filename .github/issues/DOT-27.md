---
code: DOT-27
id: 27
database_id: 445389500
node_id: MDU6SXNzdWU0NDUzODk1MDA=
status: closed
state_reason: completed
milestone:
title: "git refresh not work on master branch"
labels: ["type: bug"]
url: https://github.com/kamilsk/dotfiles/issues/27
created_at: 2019-05-17T11:08:15Z
updated_at: 2026-09-17T11:03:42Z
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
