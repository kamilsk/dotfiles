---
code: DOT-90
id: MDU6SXNzdWU3NzUwODg5MzY=
databaseId: 775088936
number: 91
url: https://github.com/kamilsk/dotfiles/issues/91
title: "combine git it and git at"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2020-12-27T18:45:29Z
updatedAt: 2026-09-17T11:15:41Z
lastEditedAt: 2026-09-17T11:15:41Z
closedAt: 2020-12-27T21:05:45Z
---

# combine git it and git at

Let `git at` behave as `git it` on an empty repository: "if git is empty, then `git at -3d` runs as `git it`". Both aliases make a dated commit; `it` initialises the repository and creates the empty root commit ([[DOT-30]]), `at` commits staged changes with a shifted date ([[DOT-77]]). When the repository has no commits yet, `at` should do the initialisation instead of failing, so that one command works in both situations.
