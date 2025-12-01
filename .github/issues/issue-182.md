---
id: 182
database_id: 976384462
node_id: MDU6SXNzdWU5NzYzODQ0NjI=
status: open
title: "git: alias: add amend|reword instead of git commend"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/182
created_at: 2021-08-22T14:01:02Z
updated_at: 2022-08-14T18:57:43Z
---

# git: alias: add amend|reword instead of git commend

https://github.blog/2021-08-16-highlights-from-git-2-33/

```bash
$ git reword <commit>
->
$ git commit --no-edit \
    --fixup=reword:<commit>
    --trailer='Signed-off-by=...'
$ EDITOR=true git rebase -i --autosquash foo^
```

```bash
$ git amend <commit>
->
$ git commit --fixup=amend
$ git rebase -i --autosquash ...
```
