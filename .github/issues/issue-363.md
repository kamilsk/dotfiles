---
id: 363
database_id: 1323283855
node_id: I_kwDOCTsueM5O37WP
status: closed
title: "deps: tools: add benchcmp"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/363
created_at: 2022-07-30T20:36:56Z
updated_at: 2022-08-03T11:09:29Z
---

# deps: tools: add benchcmp

**Motivation:** it allows to test performance.

```bash
$ go test -run=NONE -bench=. > [old,new].txt
$  benchcmp old.txt new.txt
```

```go

//go:build tools

package tools

import (
	_ "golang.org/x/tools/cmd/benchcmp"
)

//go:generate go install golang.org/x/tools/cmd/benchcmp
```
