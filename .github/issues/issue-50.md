---
id: 50
database_id: 477224982
node_id: MDU6SXNzdWU0NzcyMjQ5ODI=
status: closed
title: "improve git issue alias"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/50
created_at: 2019-08-06T07:52:50Z
updated_at: 2019-08-13T07:55:25Z
---

# improve git issue alias

How to open issue now

```bash
$ git issue | xargs open
```

How it will be

```bash
$ git issue open
```

So, the rule is `git issue [action]`, where the action is `echo` by default.
