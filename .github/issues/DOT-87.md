---
code: DOT-87
id: 88
database_id: 743565902
node_id: MDU6SXNzdWU3NDM1NjU5MDI=
status: closed
title: "git tableflip"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/88
created_at: 2020-11-16T07:07:32Z
updated_at: 2020-12-27T15:44:40Z
---

# git tableflip

Add a "throw everything away" alias that resets the working tree to `HEAD` and deletes untracked files and directories in one go:

```bash
git reset --hard
git clean -df
```

The name is the ┻━┻ gesture; the use is abandoning an experiment before switching branches, without thinking about which of the two commands is needed.

<!-- 2020-11-16T07:07Z https://github.com/kamilsk/dotfiles/issues/88#issuecomment-727782335
see table flip alias
-->
