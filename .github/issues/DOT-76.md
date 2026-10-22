---
code: DOT-76
id: MDU6SXNzdWU2MjM4MDU0MDg=
databaseId: 623805408
number: 77
url: https://github.com/kamilsk/dotfiles/issues/77
title: "add gorelease"
issueType: null
labels:
  - "help wanted"
assignees:
  - kamilsk
milestone: null
parent: null
issueFields: {}
state: CLOSED
stateReason: COMPLETED
duplicateOf: null
createdAt: 2020-05-24T06:30:54Z
updatedAt: 2026-09-17T11:14:38Z
lastEditedAt: 2026-09-17T11:14:38Z
closedAt: 2020-05-24T06:37:16Z
---

# add gorelease

Add [`gorelease`](https://pkg.go.dev/golang.org/x/exp/cmd/gorelease) to the Go toolset. It compares a Go module against its previous release, reports API changes and suggests the next semantic version — useful for the author's many small Go libraries, where deciding between a patch and a minor bump by hand is error-prone. The tool lives in `golang.org/x/exp`, which has no tagged releases; pinning it means a pseudo-version.
