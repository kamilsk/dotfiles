---
id: 367
database_id: 1323288210
node_id: I_kwDOCTsueM5O38aS
status: closed
title: "deps: tools: add git-vertag"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/367
created_at: 2022-07-30T20:40:37Z
updated_at: 2022-08-03T11:05:29Z
---

# deps: tools: add git-vertag

**Motivation:** it allows to extend the `gorelease` experience.

```bash
$  git-vertag get
v0.0.7
```

```go

//go:build tools

package tools

import (
	_ "github.com/kyoh86/git-vertag"
)

//go:generate go install github.com/kyoh86/git-vertag
```
