---
code: DOT-57
id: 58
database_id: 496633335
node_id: MDU6SXNzdWU0OTY2MzMzMzU=
status: closed
state_reason: completed
milestone:
title: "debug"
labels: ["help wanted"]
url: https://github.com/kamilsk/dotfiles/issues/58
created_at: 2019-09-21T08:59:46Z
updated_at: 2026-09-17T11:12:43Z
---

# debug

Add a `debug` helper for tracing what a command, and the shell start-up around it, actually does. The three techniques the author collected, inspired by a [Badoo article on Habr](https://habr.com/ru/company/badoo/blog/465021/):

- `env -i bash -x -l -c 'echo 123' > login.log 2>&1` — run a login shell with an empty environment and `xtrace` on, so the log shows every line of the profile files before the command;
- `strace -f env -i bash -x -l -c 'echo 123' > login.log 2>&1` — the same under `strace` to see the system calls and child processes;
- `grep -Fz SUDO_USER /proc/10684/environ` — read the environment of a running process.

The intended use is diagnosing the dotfiles themselves: which rc file sets what, why a variable or alias is missing, what a script does when started from a clean environment. The last two are Linux tools; the issue was labelled "help wanted", presumably to find the macOS equivalents.
