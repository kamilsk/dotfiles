---
code: DOT-69
id: 70
database_id: 542567764
node_id: MDU6SXNzdWU1NDI1Njc3NjQ=
status: closed
title: "git release has a problem"
labels: ["severity: critical"]
url: https://github.com/kamilsk/dotfiles/issues/70
created_at: 2019-12-26T14:17:56Z
updated_at: 2022-08-14T19:01:49Z
---

# git release has a problem

Fix a crash in `git release` when `HEAD` sits exactly on the tag:

```
.dotfiles/bin/git_current: line 38: ahead: unbound variable
```

After [#69](DOT-68.md) the script assigned `ahead` only inside the branch that recognises the `-N-gHASH` describe suffix, then read it unconditionally to append the "ahead" marker. With `set -o nounset` the read of the never-assigned variable aborted the command on every release that was checked out precisely — the common case. Labelled critical for that reason.
