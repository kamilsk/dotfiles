---
id: 288
database_id: 1220493562
node_id: I_kwDOCTsueM5Iv0D6
status: open
title: "improve git add"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/288
created_at: 2022-04-29T10:44:33Z
updated_at: 2022-08-14T18:54:09Z
---

# improve git add

`git state` shows files from git root and you can have confusion

```bash
$ git add some.file
fatal: pathspec 'some.file' did not match any files
$ pwd
/some/root/path
$ cd ../
$ git add some.file
# success
```

need to implement

```bash
$ git track some.file
# git add $(git root)/some.file
```
