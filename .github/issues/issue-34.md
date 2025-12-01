---
id: 34
database_id: 453778157
node_id: MDU6SXNzdWU0NTM3NzgxNTc=
status: closed
title: "git untag"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/34
created_at: 2019-06-08T10:05:12Z
updated_at: 2019-06-14T17:15:23Z
---

# git untag

```bash
$ git untag 0.x.y

$ git tag -d 0.x.y
$ for remote in $remotes; do git push $remotes :refs/tags/$tag; done
```
