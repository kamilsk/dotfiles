---
code: DOT-91
id: MDU6SXNzdWU3NzU3ODUzNjc=
databaseId: 775785367
number: 92
url: https://github.com/kamilsk/dotfiles/issues/92
title: "add pull alias"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2020-12-29T09:09:14Z
updatedAt: 2026-09-17T11:15:43Z
lastEditedAt: 2026-09-17T11:15:43Z
closedAt: 2020-12-29T09:25:15Z
---

# add pull alias

Add a shell alias `pull` as the readable name of `g+`, the dotfiles' "update the current branch" command. `g+` was the only spelling of the stash, fetch, rebase and update-submodules routine, and a word is easier to type in a loop or a script than a symbol pair.

Expected: `pull` and `g+` are the same command and accept the same arguments; the `push` / `g^` pair mirrors it.

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/92#issuecomment-5711717512
See the note on #190: the `pull` alias's stash restore is deferred to shell exit under bash.
-->
