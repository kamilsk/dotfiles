---
code: DOT-22
id: 22
database_id: 442565833
node_id: MDU6SXNzdWU0NDI1NjU4MzM=
status: closed
title: "review git issue alias"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/22
created_at: 2019-05-10T06:54:22Z
updated_at: 2019-05-11T09:15:20Z
---

# review git issue alias

Give `git issue` three actions: print the URL of the current branch's issue, open it in the browser, copy it to the clipboard. The original sketch:

```bash
$ git issue # print the issue url
$ git issue open # open it in a browser
$ git issue copy # copy to the buffer
```

Expected: printing is the default action, opening uses macOS `open`, copying uses `pbcopy`; the URL is built from the branch name as in the existing alias, and an unknown action is refused.
