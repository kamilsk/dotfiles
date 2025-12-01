---
id: 300
database_id: 1235251005
node_id: I_kwDOCTsueM5JoG89
status: open
title: "git: cmm should be open editor"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/300
created_at: 2022-05-13T13:33:05Z
updated_at: 2022-08-14T18:54:07Z
---

# git: cmm should be open editor

It allows to write multiline comments with extra context.

For example: multi-issue commit https://github.com/octomation/maintainer/commit/0f0d310e11c45839267c09cac1dc075754a25f5a

```
fix #33: bind flags, env and config struct for commands
fix #34: disable hub, diff and labels command
```

possible solution

1. check multi-line support
```bash
$ git cmm fix \#33: bind flags, env and config struct for commands \
fix \#34: disable hub, diff and labels command
```

2. add flag
```bash
$ git cmm -e fix \#33: bind flags, env and config struct for commands
```

3. otherwise use it by default or based on config
```bash
$ git config prefer.editor true # e.g.
```
