---
id: 146
database_id: 866767614
node_id: MDU6SXNzdWU4NjY3Njc2MTQ=
status: open
title: "refresh fork"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/146
created_at: 2021-04-24T15:07:48Z
updated_at: 2022-08-14T18:54:16Z
---

# refresh fork

```bash
$ git fetch --all --prune --force
$ git push origin 'refs/remotes/upstream/*:refs/heads/*'
$ git push mirror 'refs/remotes/upstream/*:refs/heads/*'
$ git push origin 'refs/tags/*:refs/tags/*'
$ git push mirror 'refs/tags/*:refs/tags/*'
```
