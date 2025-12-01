---
id: 123
database_id: 817883688
node_id: MDU6SXNzdWU4MTc4ODM2ODg=
status: open
title: "git shake with custom main branch"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/123
created_at: 2021-02-27T09:48:44Z
updated_at: 2022-08-14T18:54:17Z
---

# git shake with custom main branch

In Go projects, I have branches with v2+ rule, and `git shake` didn't work properly.

Changes:

```
$ git shake v5 # use v5 as a base branch
$ git shake all v5 # use v5 as a base branch for local and remotes
```
