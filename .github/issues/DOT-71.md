---
code: DOT-71
id: 72
database_id: 554584772
node_id: MDU6SXNzdWU1NTQ1ODQ3NzI=
status: closed
state_reason: completed
milestone:
title: "git release problem"
labels: ["type: bug"]
url: https://github.com/kamilsk/dotfiles/issues/72
created_at: 2020-01-24T07:29:57Z
updated_at: 2026-09-17T11:14:14Z
---

# git release problem

Settle the output format of `git release` for a commit ahead of the latest tag. Expected:

```bash
$ git release
0.7.0 166↑
```

Obtained:

```bash
$ git release
0.7.0 [166-g4d85c5c5]
```

That is: the describe suffix `-166-g4d85c5c5` should not be shown raw in brackets ([[DOT-68]] asked for `(166 ahead g4d85c5c5)`); the decision here is the compact `<tag> <n>↑`, dropping the hash, which `git log` shows anyway.

<!-- 2020-01-24T07:30Z https://github.com/kamilsk/dotfiles/issues/72#issuecomment-578022665
input

```bash
$ git describe --tags
0.7.0-166-g4d85c5c5
```
-->
