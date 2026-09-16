---
code: DOT-74
id: 75
database_id: 613368468
node_id: MDU6SXNzdWU2MTMzNjg0Njg=
status: closed
title: "add hugo"
labels: ["help wanted"]
url: https://github.com/kamilsk/dotfiles/issues/75
created_at: 2020-05-06T14:33:14Z
updated_at: 2020-05-24T06:37:45Z
---

# add hugo

Add [Hugo](https://gohugo.io), the static-site generator, to the toolset; the note points at the [v0.70.0 release](https://github.com/gohugoio/hugo/releases/tag/v0.70.0) that was current in May 2020. Hugo is written in Go, so the open question of the period was whether to build it from the `toolset` Go module like the other tools or to install the Homebrew formula — the latter is what [#76](DOT-75.md), filed the same day, argues for because of the size of Hugo's dependency tree.
