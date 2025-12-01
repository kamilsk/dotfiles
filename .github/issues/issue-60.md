---
id: 60
database_id: 512473444
node_id: MDU6SXNzdWU1MTI0NzM0NDQ=
status: closed
title: "git release didn't show postfix (rc/alpha)"
labels: [type: bug]
url: https://github.com/kamilsk/dotfiles/issues/60
created_at: 2019-10-25T11:53:09Z
updated_at: 2022-08-14T18:59:55Z
---

# git release didn't show postfix (rc/alpha)

```
$ git log
commit 234ae18a01f91e2e12dba56cc0a4956a5178729f (HEAD -> master, tag: 1.0.0-rc1, origin/master, origin/HEAD)

$ git release
1.0.0
# 1.0.0-rc1 expected
```
