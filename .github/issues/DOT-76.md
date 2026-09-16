---
code: DOT-76
id: 77
database_id: 623805408
node_id: MDU6SXNzdWU2MjM4MDU0MDg=
status: closed
title: "add gorelease"
labels: ["help wanted"]
url: https://github.com/kamilsk/dotfiles/issues/77
created_at: 2020-05-24T06:30:54Z
updated_at: 2020-05-24T06:37:16Z
---

# add gorelease

Add [`gorelease`](https://pkg.go.dev/golang.org/x/exp/cmd/gorelease) to the Go toolset. It compares a Go module against its previous release, reports API changes and suggests the next semantic version — useful for the author's many small Go libraries, where deciding between a patch and a minor bump by hand is error-prone. The tool lives in `golang.org/x/exp`, which has no tagged releases; pinning it means a pseudo-version.
