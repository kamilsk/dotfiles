---
code: DOT-89
id: 90
database_id: 775015761
node_id: MDU6SXNzdWU3NzUwMTU3NjE=
status: closed
state_reason: completed
milestone:
title: "git whoami"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/90
created_at: 2020-12-27T10:48:47Z
updated_at: 2026-09-17T11:15:39Z
---

# git whoami

Add `git whoami`, printing the identity the current repository will commit as:

```bash
$ git whoami
# git config user.name
# git config user.email
```

The author commits under several identities (personal, OctoLab, client projects, see [[DOT-422]]) and switches them per repository with the `g@` alias; a one-word check of which one is active in the current checkout avoids commits under the wrong name.

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/90#issuecomment-5711716509
Code vs intent: the ticket is closed, yet `git whoami` does not exist on a fresh setup. `bin/lib/git/whoami.bash` defines `git-whoami` but is not in the `#include` list of `bin/lib/git.bash` (only aliases, commit, stage, sync are), and `git_config` does not register `alias.whoami`; only `bin/legacy/git` does, and that script is never run. Dependents: #231 (`--author="$(git whoami)"`), #358.
-->
