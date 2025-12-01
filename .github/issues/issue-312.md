---
id: 312
database_id: 1260424273
node_id: I_kwDOCTsueM5LIIxR
status: closed
title: "deps: tools: broken go tools"
labels: [type: bug]
url: https://github.com/kamilsk/dotfiles/issues/312
created_at: 2022-06-03T21:57:34Z
updated_at: 2022-08-14T18:59:36Z
---

# deps: tools: broken go tools

```
# github.com/cube2222/octosql/datasources/parquet
../../go/pkg/mod/github.com/cube2222/octosql@v0.7.2/datasources/parquet/execution.go:40:14: pf.Schema().MakeColumnReadRowFunc undefined (type *"github.com/segmentio/parquet-go".Schema has no field or method MakeColumnReadRowFunc)
tools.go:24: running "go": exit status 2
```
