---
code: DOT-44
id: 45
database_id: 465571654
node_id: MDU6SXNzdWU0NjU1NzE2NTQ=
status: closed
title: "coverall"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/45
created_at: 2019-07-09T05:07:42Z
updated_at: 2026-09-17T11:10:44Z
---

# coverall

Add a `coverall` command that reports test coverage for a whole Go project in one call: run `go test -cover` package by package and print a compact table with a total, instead of reading the raw per-package output. The original sketch:

```bash
$ coverall [flags]
# runs go test [glags] -cover in for loop
```

Extra flags are forwarded to `go test`. The expected output is one line per package with its coverage percentage, and a final total; packages without tests should still appear rather than break the table.

<!-- 2019-07-09T05:09Z https://github.com/kamilsk/dotfiles/issues/45#issuecomment-509490323
https://github.com/h12w/gosweep/blob/master/gosweep.sh
-->

<!-- 2019-07-09T05:29Z https://github.com/kamilsk/dotfiles/issues/45#issuecomment-509494202
- [x] replace `[no test files]` by `0.0%` or remove it if doesn't have go files
- [x] skip `examples` if it doesn't have go test files
- [x] replace `(cached)	coverage: 79.3% of statements` by `79.3%`
- [x] print total coverage value
-->

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/45#issuecomment-5711706039
Note: `bin/legacy/coverall` is kept but `bin/legacy` is not on `PATH` (`_bins` is `~/.dotfiles/bin` only), so the script is archival; nothing in the repository invokes it.
-->
