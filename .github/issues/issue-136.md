---
id: 136
database_id: 837157229
node_id: MDU6SXNzdWU4MzcxNTcyMjk=
status: open
title: "git proxy"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/136
created_at: 2021-03-21T19:05:18Z
updated_at: 2022-08-14T18:52:29Z
---

# git proxy

```bash
alias git="tig"
```

extra commands are extensions, not aliases

```bash
$ git state
> git state -> tig state -> cobra state command
$ git status
> git status -> git status
```

prevent recursive call
