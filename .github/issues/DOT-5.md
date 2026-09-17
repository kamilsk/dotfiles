---
code: DOT-5
id: 5
database_id: 393913739
node_id: MDU6SXNzdWUzOTM5MTM3Mzk=
status: closed
state_reason: completed
milestone:
title: "add alias git refresh"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/5
created_at: 2018-12-24T17:30:12Z
updated_at: 2026-09-17T11:11:31Z
---

# add alias git refresh

Add a `git refresh` alias that brings the current branch up to date with the remote default branch: fetch every remote with pruning, then rebase onto `<remote>/<default>`. The original one-line spec: "if current branch != default branch then git fetch --all -p and git rebase remote/default". The point is to rebase a feature branch on top of the freshly fetched trunk with one word, without typing the remote and branch names; the flow's `done` step later relies on it.

Expected: after `git refresh` the branch contains everything on the remote default branch, local commits are replayed on top, stale remote-tracking refs are pruned. The spec skipped the case where the current branch is the default one; whether tags should be fetched was not said.

<!-- 2018-12-24T20:32Z https://github.com/kamilsk/dotfiles/issues/5#issuecomment-449769488
final flow must be

```bash
$ git start ISSUE-XXX # create fresh branch from default if not exists or checkout
...
$ git add .
$ git progress some description # commit with prefix (issue number)
...
$ git add .
$ git commend # commit --ammend --no-edit
...
$ git refresh # rebase from fresh remote' default branch
$ git please # push --force-with-lease
$ git done # switch to default branch if nothing to push to remote
```
-->

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/5#issuecomment-5711714032
Note: `alias.refresh` is registered only by `bin/legacy/git` (never executed), so `git refresh` is unavailable on machines configured after 2022; `git_refresh` works. Same for the whole legacy set, see the note on #359.
-->
