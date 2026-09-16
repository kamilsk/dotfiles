---
code: DOT-38
id: 39
database_id: 459566455
node_id: MDU6SXNzdWU0NTk1NjY0NTU=
status: closed
title: "experiment with TMOUT environment"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/39
created_at: 2019-06-23T11:43:22Z
updated_at: 2026-09-17T11:08:57Z
---

# experiment with TMOUT environment

Try the shell's idle timeout: put `TMOUT=300` into `.bash_profile` so that an interactive shell left alone for five minutes exits by itself. `TMOUT` is the bash/zsh variable that makes `read` and the interactive prompt time out; the experiment was about whether auto-closing forgotten terminals (and the sessions, sudo tickets and SSH connections inside them) is a habit worth adopting.
