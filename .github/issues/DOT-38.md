---
code: DOT-38
id: MDU6SXNzdWU0NTk1NjY0NTU=
databaseId: 459566455
number: 39
url: https://github.com/kamilsk/dotfiles/issues/39
title: "experiment with TMOUT environment"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-06-23T11:43:22Z
updatedAt: 2026-09-17T11:08:57Z
lastEditedAt: 2026-09-17T11:08:57Z
closedAt: 2019-06-24T06:50:03Z
---

# experiment with TMOUT environment

Try the shell's idle timeout: put `TMOUT=300` into `.bash_profile` so that an interactive shell left alone for five minutes exits by itself. `TMOUT` is the bash/zsh variable that makes `read` and the interactive prompt time out; the experiment was about whether auto-closing forgotten terminals (and the sessions, sudo tickets and SSH connections inside them) is a habit worth adopting.
