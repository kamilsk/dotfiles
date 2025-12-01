---
id: 416
database_id: 1371193321
node_id: I_kwDOCTsueM5Rur_p
status: open
title: "git: alias: unified abort command"
labels: [type: feature, scope: code, impact: medium, effort: medium]
url: https://github.com/kamilsk/dotfiles/issues/416
created_at: 2022-09-13T10:06:18Z
updated_at: 2022-09-13T10:06:19Z
---

# git: alias: unified abort command

**Motivation:** improve the developer experience and reduce code typing.

**Interface**

```bash
$ git abort
# instead of
# git merge --abort
# git rebase --abort
# git cherry-pick --abort
```
