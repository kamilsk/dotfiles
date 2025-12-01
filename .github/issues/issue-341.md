---
id: 341
database_id: 1292791660
node_id: I_kwDOCTsueM5NDm9s
status: closed
title: "env: split configuration by hosts"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/341
created_at: 2022-07-04T08:08:22Z
updated_at: 2022-08-10T09:38:14Z
---

# env: split configuration by hosts

**Motivation:** not all mac should be similar by performance reason.

Split configuration by `uname -n` call

```bash
$ uname -n
OctoMacLegacy.local
```
