---
code: DOT-72
id: MDU6SXNzdWU1NTY0NDg5OTk=
databaseId: 556448999
number: 73
url: https://github.com/kamilsk/dotfiles/issues/73
title: "gopath alias"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2020-01-28T20:26:44Z
updatedAt: 2026-09-17T11:14:26Z
lastEditedAt: 2026-09-17T11:14:26Z
closedAt: 2020-01-29T20:32:03Z
---

# gopath alias

Add a `gopath` helper that clones a repository straight into its `GOPATH` import path, for the pre-modules layout where `github.com/kamilsk/retry` had to live at `$GOPATH/src/github.com/kamilsk/retry`. The original sketch and the intended steps:

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

Both URL forms map to the same directory; the special case rewrites the SSH host and port of the author's employer's Bitbucket into the import path its Go code used. The expected result is a clone at the right place under `src`, created with `mkdir -p`, without the user computing the path.

<!-- 2020-01-29T16:59Z https://github.com/kamilsk/dotfiles/issues/73#issuecomment-579856027
`gopath ssh://git@stash.msk.avito.ru:7999/gl/item-aggregator.git`
-->
