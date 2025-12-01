---
id: 328
database_id: 1276408216
node_id: I_kwDOCTsueM5MFHGY
status: closed
title: "script: update: extend by git"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/328
created_at: 2022-06-20T06:02:25Z
updated_at: 2022-06-20T09:04:49Z
---

# script: update: extend by git

**Motivation:** `git pull` is not enough, sometimes I want to update submodules.

**Interface**

```bash
$ update git
#  - check __git
#  - git pull
#  - git submodule update --init --recursive --remote --merge
```
