---
code: DOT-90
id: 91
database_id: 775088936
node_id: MDU6SXNzdWU3NzUwODg5MzY=
status: closed
title: "combine git it and git at"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/91
created_at: 2020-12-27T18:45:29Z
updated_at: 2026-09-17T11:15:41Z
---

# combine git it and git at

Let `git at` behave as `git it` on an empty repository: "if git is empty, then `git at -3d` runs as `git it`". Both aliases make a dated commit; `it` initialises the repository and creates the empty root commit ([#30](DOT-30.md)), `at` commits staged changes with a shifted date ([#78](DOT-77.md)). When the repository has no commits yet, `at` should do the initialisation instead of failing, so that one command works in both situations.
