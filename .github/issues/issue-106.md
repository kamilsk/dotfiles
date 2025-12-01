---
id: 106
database_id: 790744311
node_id: MDU6SXNzdWU3OTA3NDQzMTE=
status: closed
title: "improve lookup"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/106
created_at: 2021-01-21T06:35:45Z
updated_at: 2021-01-21T07:57:45Z
---

# improve lookup

```bash
$ lookup pull
pull
$ which pull
pull () {
        git pull --all --prune --tags --force --rebase
        git submodule update --init --recursive
}
```
