---
code: DOT-9
id: MDU6SXNzdWUzOTcyMTQ4MzI=
databaseId: 397214832
number: 9
url: https://github.com/kamilsk/dotfiles/issues/9
title: "fix self-update at linux"
labels:
  - "type: bug"
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-01-09T05:13:15Z
updatedAt: 2026-09-17T11:15:36Z
lastEditedAt: 2026-09-17T11:15:36Z
closedAt: 2019-01-10T05:12:37Z
---

# fix self-update at linux

Make `self-update` survive on a machine without Oh My Zsh. Run as root on Linux, the script pulled the dotfiles and then died:

```
Already up-to-date.
dotfiles were updated
/root/.dotfiles/bin/self-update: line 12: ZSH: unbound variable
```

The script runs with `set -u`; the Oh My Zsh step read `$ZSH` (exported by `.zshrc` on the author's Mac) unconditionally, so on any host where the variable is not set — a Linux box, a bash-only login, a server — the whole update aborted after the dotfiles step, and the remaining steps never ran.

Expected: the Oh My Zsh update is skipped when there is no Oh My Zsh, and the rest of `self-update` proceeds.

<!-- 2019-01-10T05:12Z https://github.com/kamilsk/dotfiles/issues/9#issuecomment-452973154
fixed
-->

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/9#issuecomment-5711716999
Note: Linux support is nominal. `install` knows the Linuxbrew prefix, but the Brewfiles, `mas`, `toolset/Apps`, `mac.bash`, `pbcopy`/`open`-based helpers and the hard-coded `/opt/homebrew` in `env.bash` all assume macOS.
-->
