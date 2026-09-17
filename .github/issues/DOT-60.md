---
code: DOT-60
id: 61
database_id: 512865957
node_id: MDU6SXNzdWU1MTI4NjU5NTc=
status: closed
state_reason: completed
milestone:
title: "git continue alias"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/61
created_at: 2019-10-26T17:58:05Z
updated_at: 2026-09-17T11:13:07Z
---

# git continue alias

Add a context-aware `git continue` that runs whichever of `git merge --continue` or `git rebase --continue` applies to the repository's current state (a paused merge or a paused rebase), so that the author does not have to remember which operation is in progress before finishing it.

The detection is straightforward from `.git`: `MERGE_HEAD` marks a merge, `rebase-merge/` or `rebase-apply/` a rebase; `cherry-pick` and `revert` have their own sequencer state and `--continue` flags too.

<!-- 2019-11-19T16:03Z https://github.com/kamilsk/dotfiles/issues/61#issuecomment-555575845
won't do
-->
