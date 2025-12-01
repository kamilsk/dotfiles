---
id: 358
database_id: 1322575858
node_id: I_kwDOCTsueM5O1Ofy
status: open
title: "git: alias: refactor alias.whoami and alias.delta"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/358
created_at: 2022-07-29T18:47:56Z
updated_at: 2025-08-10T06:51:44Z
---

# git: alias: refactor alias.whoami and alias.delta

**Motivation:** improve code quality and remove `git_*` scripts, see #355.

**To do**

- rename `git/whoami.bash` into `git/info.bash`
- replace script by `!@ git-whoami`
- add function `git-delta`
- replace alias by `!@ git-delta`
