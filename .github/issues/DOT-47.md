---
code: DOT-47
id: MDU6SXNzdWU0NzA3NTM0MTQ=
databaseId: 470753414
number: 48
url: https://github.com/kamilsk/dotfiles/issues/48
title: "improve git_mirror"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-07-21T07:44:58Z
updatedAt: 2026-09-17T11:11:13Z
lastEditedAt: 2026-09-17T11:11:13Z
closedAt: 2019-07-21T11:54:23Z
---

# improve git_mirror

Let `git mirror` guess the Bitbucket URL when no argument is given: "just replace git@github.com by git@bitbucket.org if a first argument is omitted." The author's mirrors lived under the same owner and name on both hostings, so the SSH URL of `origin` with the host swapped is the mirror's URL, and the command should not need it typed.

Expected: `git mirror` with no argument reads the `origin` fetch URL, rewrites the host, and adds or updates the `mirror` remote; when `origin` is not a `git@github.com` URL the command says it cannot define the mirror instead of registering a wrong one; `git mirror <url>` keeps working.
