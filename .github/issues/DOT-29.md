---
code: DOT-29
id: MDU6SXNzdWU0NDgyNDQ1NzE=
databaseId: 448244571
number: 29
url: https://github.com/kamilsk/dotfiles/issues/29
title: "partial self-update"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-05-24T16:01:31Z
updatedAt: 2026-09-17T11:04:34Z
lastEditedAt: 2026-09-17T11:04:34Z
closedAt: 2019-06-18T05:08:21Z
---

# partial self-update

Let `self-update` update a chosen subset instead of everything. By then the script pulled the dotfiles and refreshed Oh My Zsh, Homebrew and Docker images in one go ([[DOT-2]]), which is slow when only the dotfiles are wanted. The sketched interface:

```
$ self-update
-> update only dotfiles
$ self-update +brew
-> update dotfiles and brew
$ self-update all
-> update all (as now)
```

That is: no argument means the cheap default, `all` keeps the old behaviour, and `+<target>` adds a target on top of the default.
