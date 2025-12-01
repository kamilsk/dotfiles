---
id: 135
database_id: 835639350
node_id: MDU6SXNzdWU4MzU2MzkzNTA=
status: closed
title: "lookup git state has an error"
labels: [help wanted]
url: https://github.com/kamilsk/dotfiles/issues/135
created_at: 2021-03-19T07:12:45Z
updated_at: 2021-03-19T07:26:54Z
---

# lookup git state has an error

```bash
$ lookup git state
git alias: !git status && (echo; echo Stash content) && (git stash list | grep . || echo -) && (echo; printf 'Latest release: '; git release || true)
error: key does not contain variable name: alias.
git alias: 
 not found
$ echo $?
1
```
