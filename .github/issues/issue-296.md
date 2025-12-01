---
id: 296
database_id: 1228588583
node_id: I_kwDOCTsueM5JOsYn
status: open
title: "pull should respect main branch renaming"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/296
created_at: 2022-05-07T10:08:46Z
updated_at: 2022-08-14T18:54:09Z
---

# pull should respect main branch renaming

```bash
$ git branch
master

$ git branch -a
master
remotes/origin/master

$ git status
On branch master
Your branch is up to date with 'origin/master'.

# rename origin branch

$ pull
# fetch all
# check that remote branch deleted and new appeared (renamed)
# rename current branch
# attach current branch
```
