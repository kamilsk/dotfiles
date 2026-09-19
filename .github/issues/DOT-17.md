---
code: DOT-17
id: MDU6SXNzdWU0NDE2NjcxNDk=
databaseId: 441667149
number: 17
url: https://github.com/kamilsk/dotfiles/issues/17
title: "run git_config when self-update did"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-05-08T10:37:42Z
updatedAt: 2026-09-17T10:59:18Z
lastEditedAt: 2026-09-17T10:59:18Z
closedAt: 2019-05-09T12:05:52Z
---

# run git_config when self-update did

Reapply the global git configuration at the end of `self-update`. The aliases and settings live in the [git_config](../../bin/git_config) script, and a pull that changes that script has no effect until the script is run again; the author kept forgetting to run it, so the update should do it.

Expected: after `self-update`, `~/.gitconfig` reflects the pulled version of `git_config` without a separate step.
