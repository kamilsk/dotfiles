---
code: DOT-14
id: 14
database_id: 440306054
node_id: MDU6SXNzdWU0NDAzMDYwNTQ=
status: closed
title: "define git cmm like as git progress"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/14
created_at: 2019-05-04T09:54:11Z
updated_at: 2026-09-17T10:58:00Z
---

# define git cmm like as git progress

Let `git cmm` take its message from the rest of the command line, the way the flow's `progress` alias did, so that quoting is optional:

`git cmm 'do some commit'` -> `git cmm do some commit`

`cmm` is the author's short commit alias; typing a one-line message without quotes is the common case, and the alias should join the words for `-m` itself. The quoted form has to keep working, since a single argument with spaces is just one word to join.
