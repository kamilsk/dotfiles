---
id: 172
database_id: 906799303
node_id: MDU6SXNzdWU5MDY3OTkzMDM=
status: open
title: "write a migrator"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/172
created_at: 2021-05-30T15:52:58Z
updated_at: 2022-08-14T18:52:29Z
---

# write a migrator

the problem:

- I used golangci-lint, but switched to the fork. How to cleanup tap and installation exactly once?
- I used looppointer, but now it's part of the fork. How to remove it from the GOPATH/bin?

the solution:

```bash
$ self-update all
# fetch new migrations
# apply it to the current state
# if it goes back, fetch downgrade migrations and apply them
```
