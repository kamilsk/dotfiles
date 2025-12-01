---
id: 374
database_id: 1330983901
node_id: I_kwDOCTsueM5PVTPd
status: open
title: "bash: update: add compose option"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/374
created_at: 2022-08-07T11:07:35Z
updated_at: 2022-08-14T18:54:06Z
---

# bash: update: add compose option

**Motivation:** use a fixed version of docker images instead of "latest", etc., and update it manually.

**Interface**

```bash
$ update compose [postgres]
# fetch tags from docker hub
# choose an appropriate one
```
