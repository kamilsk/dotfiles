---
code: DOT-69
id: MDU6SXNzdWU1NDI1Njc3NjQ=
databaseId: 542567764
number: 70
url: https://github.com/kamilsk/dotfiles/issues/70
title: "git release has a problem"
labels:
  - "severity: critical"
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-12-26T14:17:56Z
updatedAt: 2026-09-17T11:14:06Z
lastEditedAt: 2026-09-17T11:14:06Z
closedAt: 2019-12-26T21:03:20Z
---

# git release has a problem

Fix a crash in `git release` when `HEAD` sits exactly on the tag:

```
.dotfiles/bin/git_current: line 38: ahead: unbound variable
```

After [[DOT-68]] the script assigned `ahead` only inside the branch that recognises the `-N-gHASH` describe suffix, then read it unconditionally to append the "ahead" marker. With `set -o nounset` the read of the never-assigned variable aborted the command on every release that was checked out precisely — the common case. Labelled critical for that reason.
