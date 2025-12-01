---
id: 337
database_id: 1287720225
node_id: I_kwDOCTsueM5MwQ0h
status: open
title: "git: alias: add del/delete with multi-type input"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/337
created_at: 2022-06-28T18:20:51Z
updated_at: 2022-08-14T18:54:08Z
---

# git: alias: add del/delete with multi-type input

**Motivation:** I'm so lazy to remember and use different commands to get things done, e.g.

```bash
$ git branch -D some/branch
# + remove remote branch (?)
$ git tag -d some-tag
# + remove remote tag (?)
$ git rm -rf some/path
# etc
```

Instead of it, I want to something like this

```bash
$ git del some/branch
$ git del some-tag
$ git del some/path
```
