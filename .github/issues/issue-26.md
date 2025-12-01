---
id: 26
database_id: 444798512
node_id: MDU6SXNzdWU0NDQ3OTg1MTI=
status: closed
title: "add git detach alias"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/26
created_at: 2019-05-16T07:34:25Z
updated_at: 2019-06-18T19:31:39Z
---

# add git detach alias

```bash
$ git detach 0.0.2 || git detach current
> git tag -d 0.0.2
> git push <remote> :refs/tags/0.0.2
```
