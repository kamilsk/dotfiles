---
id: 630
database_id: 1938098090
node_id: I_kwDOCTsueM5zhQeq
status: open
title: "command: notify if a run is longer than X sec"
labels: [type: feature, scope: code, impact: medium, effort: easy]
url: https://github.com/kamilsk/dotfiles/issues/630
created_at: 2023-10-11T15:28:34Z
updated_at: 2023-10-11T15:29:08Z
---

# command: notify if a run is longer than X sec

**Motivation:** better DX when I run long execution scripts.

**PoC**

```bash
$ notify -5s go run main.go
# if go run main.go execution time >5s then exec
# osascript -e 'display notification "The command `go run main.go` is complete! Exec time... Status code..." with title "Script execution"'
```
