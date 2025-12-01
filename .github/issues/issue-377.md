---
id: 377
database_id: 1331106842
node_id: I_kwDOCTsueM5PVxQa
status: open
title: "git: alias: contribute: bug with clean history"
labels: [type: bug]
url: https://github.com/kamilsk/dotfiles/issues/377
created_at: 2022-08-07T19:49:06Z
updated_at: 2022-09-28T13:35:30Z
---

# git: alias: contribute: bug with clean history

**Steps to reproduce**

1. `git branch --orphan new`
2. `git add .`
3. `git contribute ...`

```bash
$ git contribute describe repo and add license
fatal: your current branch 'new' does not have any commits yet
Error: please provide argument in format YYYY[-mm[-dd]], e.g., 2006-01: invalid argument "": unsupported format
fatal: invalid date format:
```

The problem is how to define optimal suggested time.
