---
code: DOT-17
id: 17
database_id: 441667149
node_id: MDU6SXNzdWU0NDE2NjcxNDk=
status: closed
title: "run git_config when self-update did"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/17
created_at: 2019-05-08T10:37:42Z
updated_at: 2026-09-17T10:59:18Z
---

# run git_config when self-update did

Reapply the global git configuration at the end of `self-update`. The aliases and settings live in the [git_config](../../bin/git_config) script, and a pull that changes that script has no effect until the script is run again; the author kept forgetting to run it, so the update should do it.

Expected: after `self-update`, `~/.gitconfig` reflects the pulled version of `git_config` without a separate step.
