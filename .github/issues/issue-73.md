---
id: 73
database_id: 556448999
node_id: MDU6SXNzdWU1NTY0NDg5OTk=
status: closed
title: "gopath alias"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/73
created_at: 2020-01-28T20:26:44Z
updated_at: 2020-01-29T20:32:03Z
---

# gopath alias

```bash
$ gopath https://github.com/kamilsk/retry.git
$ gopath git@github.com:kamilsk/retry.git
```

1. normalize to src path: github.com/kamilsk/retry
  - trim .git
  - trim https:// or git@
  - map stash.msk.avito.ru:7999 -> go.avito.ru
  - replace : by /
2. mkdir -p $GOPATH/src/github.com/kamilsk/retry
3. git clone ... $GOPATH/src/github.com/kamilsk/retry

profit
