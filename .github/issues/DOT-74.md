---
code: DOT-74
id: MDU6SXNzdWU2MTMzNjg0Njg=
databaseId: 613368468
number: 75
url: https://github.com/kamilsk/dotfiles/issues/75
title: "add hugo"
labels:
  - "help wanted"
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2020-05-06T14:33:14Z
updatedAt: 2026-09-17T11:14:31Z
lastEditedAt: 2026-09-17T11:14:31Z
closedAt: 2020-05-24T06:37:15Z
---

# add hugo

Add [Hugo](https://gohugo.io), the static-site generator, to the toolset; the note points at the [v0.70.0 release](https://github.com/gohugoio/hugo/releases/tag/v0.70.0) that was current in May 2020. Hugo is written in Go, so the open question of the period was whether to build it from the `toolset` Go module like the other tools or to install the Homebrew formula — the latter is what [[DOT-75]], filed the same day, argues for because of the size of Hugo's dependency tree.
