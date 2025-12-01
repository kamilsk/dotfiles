---
id: 509
database_id: 1536152012
node_id: I_kwDOCTsueM5bj9HM
status: closed
title: "git: push: avoid fork-*"
labels: [help wanted, type: improvement, scope: code, impact: medium, effort: easy]
url: https://github.com/kamilsk/dotfiles/issues/509
created_at: 2023-01-17T10:36:12Z
updated_at: 2023-01-23T17:21:06Z
---

# git: push: avoid fork-*

**Motivation:** forks are unavailable to pushing.

```bash
$ push
To github.com:DimovyM/web-tact.git
 ! [remote rejected] main -> main (permission denied)
 ! [remote rejected] v0.0.1 -> v0.0.1 (permission denied)
 ! [remote rejected] v0.0.2 -> v0.0.2 (permission denied)
 ! [remote rejected] v0.0.3 -> v0.0.3 (permission denied)
 ! [remote rejected] v0.0.4 -> v0.0.4 (permission denied)
 ! [remote rejected] v0.0.5 -> v0.0.5 (permission denied)
 ! [remote rejected] v0.0.6 -> v0.0.6 (permission denied)
error: failed to push some refs to 'github.com:DimovyM/web-tact.git'
```

The better way is to exclude forks from push.
