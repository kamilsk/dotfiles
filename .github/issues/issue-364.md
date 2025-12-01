---
id: 364
database_id: 1323285087
node_id: I_kwDOCTsueM5O37pf
status: closed
title: "deps: tools: add gomvpkg"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/364
created_at: 2022-07-30T20:37:54Z
updated_at: 2022-08-03T11:08:39Z
---

# deps: tools: add gomvpkg

**Motivation:** it allows to do refactoring.

```bash
$  gomvpkg -from <path>  -to <path>
```

```go

//go:build tools

package tools

import (
	_ "golang.org/x/tools/cmd/gomvpkg"
)

//go:generate go install golang.org/x/tools/cmd/gomvpkg
```
