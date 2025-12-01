---
id: 369
database_id: 1326083743
node_id: I_kwDOCTsueM5PCm6f
status: closed
title: "deps: tools: add gorelease"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/369
created_at: 2022-08-02T16:14:47Z
updated_at: 2022-08-03T11:04:29Z
---

# deps: tools: add gorelease

**Motivation:** it's experimental feature now.

Related to octomation/go-module/issues/45.


```go
_ "golang.org/x/exp/cmd/gorelease"

//go:generate go install golang.org/x/exp/cmd/gorelease
```
