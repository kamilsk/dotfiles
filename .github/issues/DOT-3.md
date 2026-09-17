---
code: DOT-3
id: 3
database_id: 388198702
node_id: MDU6SXNzdWUzODgxOTg3MDI=
status: closed
state_reason: completed
milestone:
title: "add prepare alias"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/3
created_at: 2018-12-06T12:47:03Z
updated_at: 2026-09-17T11:05:00Z
---

# add prepare alias

Add a `prepare` step that turns a bare Mac into the author's environment: install Homebrew, install the packages the shell depends on (`zsh`, `zsh-completions`), install Oh My Zsh, set up Visual Studio Code per its [macOS guide](https://code.visualstudio.com/docs/setup/mac) and whatever else a fresh machine needs. The list was a checklist of manual steps, not a design:

```
- download brew
- download required brew packages
  - zsh
  - zsh_completion
- install oh my zsh
- https://code.visualstudio.com/docs/setup/mac
- etc
```

The intent is that bootstrapping is scripted and repeatable, so that the dotfiles can be installed on a new machine without a memory of what has to be done first.

<!-- 2018-12-06T12:47Z https://github.com/kamilsk/dotfiles/issues/3#issuecomment-444859787
implement it as steps, add bin dir and inject bin to path
-->

<!-- 2018-12-15T08:43Z https://github.com/kamilsk/dotfiles/issues/3#issuecomment-447550698
will be done in #4
-->
