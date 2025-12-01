---
id: 356
database_id: 1322571431
node_id: I_kwDOCTsueM5O1Nan
status: open
title: "git: alias: refactor alias.force and alias.please"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/356
created_at: 2022-07-29T18:41:56Z
updated_at: 2025-08-10T06:51:16Z
---

# git: alias: refactor alias.force and alias.please

**Motivation:** improve code quality and remove `git_*` scripts, see #355.

**To do**

- move them into `git/sync.bash`
- replace by `!@ git-force` and `!@ git-please`
- make a decision about `git-force` rationality
