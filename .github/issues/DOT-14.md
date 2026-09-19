---
code: DOT-14
id: MDU6SXNzdWU0NDAzMDYwNTQ=
databaseId: 440306054
number: 14
url: https://github.com/kamilsk/dotfiles/issues/14
title: "define git cmm like as git progress"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-05-04T09:54:11Z
updatedAt: 2026-09-17T10:58:00Z
lastEditedAt: 2026-09-17T10:58:00Z
closedAt: 2019-05-05T05:50:58Z
---

# define git cmm like as git progress

Let `git cmm` take its message from the rest of the command line, the way the flow's `progress` alias did, so that quoting is optional:

`git cmm 'do some commit'` -> `git cmm do some commit`

`cmm` is the author's short commit alias; typing a one-line message without quotes is the common case, and the alias should join the words for `-m` itself. The quoted form has to keep working, since a single argument with spaces is just one word to join.
