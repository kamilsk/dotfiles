---
code: DOT-29
id: 29
database_id: 448244571
node_id: MDU6SXNzdWU0NDgyNDQ1NzE=
status: closed
title: "partial self-update"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/29
created_at: 2019-05-24T16:01:31Z
updated_at: 2019-06-18T05:08:21Z
---

# partial self-update

Let `self-update` update a chosen subset instead of everything. By then the script pulled the dotfiles and refreshed Oh My Zsh, Homebrew and Docker images in one go ([#2](DOT-2.md)), which is slow when only the dotfiles are wanted. The sketched interface:

```
$ self-update
-> update only dotfiles
$ self-update +brew
-> update dotfiles and brew
$ self-update all
-> update all (as now)
```

That is: no argument means the cheap default, `all` keeps the old behaviour, and `+<target>` adds a target on top of the default.
