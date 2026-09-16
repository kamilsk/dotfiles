---
code: DOT-2
id: 2
database_id: 388198340
node_id: MDU6SXNzdWUzODgxOTgzNDA=
status: closed
title: "improve self-update"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/2
created_at: 2018-12-06T12:45:51Z
updated_at: 2018-12-16T13:58:38Z
---

# improve self-update

Make `self-update` refresh more than the dotfiles checkout. At the time it only pulled the repository; the note lists three more things the author was doing by hand after every pull: upgrading Oh My Zsh (`upgrade_oh_my_zsh`, the framework's own updater), upgrading Homebrew packages (the `brew+` alias of that time) and re-pulling Docker images (`images+`).

The original list:

```
- upgrade_oh_my_zsh
- brew+
- images+
```

The intent is one command that brings the whole workstation up to date, not just the scripts in `~/.dotfiles`, so that "update everything" does not depend on remembering three separate tools.

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/2#issuecomment-5711688652
Code vs intent: `self-update` ends with `(cd "${root}" && git reset --hard)` regardless of target. `ensure_clean` (2026) prevents starting with local changes, but the reset is still there and both 2026 reviews rate it Crit/High. Also `update_brew` applies *either* the per-host Brewfile *or* the common one, never both: on hosts with `toolset/custom/<host>.Brewfile` the common `toolset/Brewfile` is ignored by `self-update` (while `install` applies both), and `--force-cleanup` would remove anything the custom file does not list. It works only because each custom file duplicates the common entries by hand — a change to the common file must be mirrored into three host files.
-->
