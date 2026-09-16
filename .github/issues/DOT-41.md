---
code: DOT-41
id: 42
database_id: 461934331
node_id: MDU6SXNzdWU0NjE5MzQzMzE=
status: closed
title: "stash which or where"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/42
created_at: 2019-06-28T09:05:05Z
updated_at: 2019-07-13T12:36:04Z
---

# stash which or where

Add a `which` (or `where`) subcommand to the `stash` command recorder ([#38](DOT-37.md)) that prints the path of the file where the commands are being recorded:

```bash
$ stash which|where
/usr/home/.stash
```

The point is discoverability: the recorder writes to a hidden file in the home directory, and a user who wants to edit the recorded sequence by hand, or copy it elsewhere, should not have to read the script to learn where it is. The exact spelling (`which` vs `where`) was left open in the title.

<!-- 2019-07-13T12:36Z https://github.com/kamilsk/dotfiles/issues/42#issuecomment-511118818
moved to kamilsk/stash/issues/2
-->
