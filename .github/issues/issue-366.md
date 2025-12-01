---
id: 366
database_id: 1323286956
node_id: I_kwDOCTsueM5O38Gs
status: closed
title: "deps: tools: add marwan-at-work/mod"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/366
created_at: 2022-07-30T20:39:34Z
updated_at: 2022-08-03T11:06:32Z
---

# deps: tools: add marwan-at-work/mod

**Motivation:** it allows to update a major version of a dependency.

```bash
$  mod upgrade --mod-name=github.com/google/go-github/v44
# update it to v45
```

```go

//go:build tools

package tools

import (
	_ "github.com/marwan-at-work/mod/cmd/mod"
)

//go:generate go install github.com/marwan-at-work/mod/cmd/mod
```
