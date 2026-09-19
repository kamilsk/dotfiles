---
code: DOT-20
id: MDU6SXNzdWU0NDIxNzIxODQ=
databaseId: 442172184
number: 20
url: https://github.com/kamilsk/dotfiles/issues/20
title: "remove bash_completions"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-05-09T10:45:15Z
updatedAt: 2026-09-17T11:00:39Z
lastEditedAt: 2026-09-17T11:00:39Z
closedAt: 2019-05-09T11:59:24Z
---

# remove bash_completions

Drop the Homebrew `bash-completion` package and its wiring from the dotfiles. The title is the whole note; in May 2019 the author's interactive shell was already zsh with Oh My Zsh, so the bash completion machinery installed by the Brewfile was dead weight on every install and update.

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/20#issuecomment-5711689158
Code vs intent: `config/bash/.bash_profile` still sources `/usr/local/etc/profile.d/bash_completion.sh` — the Intel Homebrew path — even though `bash-completion` is no longer declared anywhere. Harmless (guarded by `-r`), but a leftover of what this ticket removed, and wrong for `/opt/homebrew`.
-->
