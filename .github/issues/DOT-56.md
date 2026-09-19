---
code: DOT-56
id: MDU6SXNzdWU0ODc4MDQ1MTc=
databaseId: 487804517
number: 57
url: https://github.com/kamilsk/dotfiles/issues/57
title: "improve git_mirror"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-08-31T19:37:35Z
updatedAt: 2026-09-17T11:12:38Z
lastEditedAt: 2026-09-17T11:12:38Z
closedAt: 2019-09-02T14:59:16Z
---

# improve git_mirror

Two improvements for the mirror command: register `git mirror` as an alias of the `git_mirror` script, and add `git mirror open`, which opens the mirror's web page the way `git open` ([[DOT-55]]) opens the origin's. The original list: "git mirror <- git_mirror; git mirror open, the same as git open but for mirror".

Expected: `git mirror`, with and without a URL ([[DOT-36]], [[DOT-47]]), is available as a git subcommand; `git mirror open` translates the `mirror` remote's SSH URL to HTTPS and opens it; if there is no `mirror` remote, it says so.
