---
code: DOT-77
id: 78
database_id: 651830906
node_id: MDU6SXNzdWU2NTE4MzA5MDY=
status: closed
title: "add git at alias"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/78
created_at: 2020-07-06T21:29:42Z
updated_at: 2020-07-08T19:00:25Z
---

# add git at alias

Add `git at <offset> <message>`: a commit whose author and committer dates are shifted by a relative offset, so that work done offline or in a batch can be recorded at the moment it happened.

```bash
$ git at 1d
# GIT_COMMITTER_DATE="$(date -j -v-1d)"; git commit --date="${GIT_COMMITTER_DATE}" -m ...
```

`--date` sets only the author date; the committer date has to come from `GIT_COMMITTER_DATE`, and both must match for GitHub's contribution calendar to place the commit where intended. The offset syntax is BSD `date -v` (`-1d`, `-3d2h`), macOS-only.
