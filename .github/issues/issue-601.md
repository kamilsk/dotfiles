---
id: 601
database_id: 1834610511
node_id: I_kwDOCTsueM5tWe9P
status: open
title: "git: alias: deinit submodule"
labels: [type: feature, scope: code, impact: medium, effort: easy]
url: https://github.com/kamilsk/dotfiles/issues/601
created_at: 2023-08-03T09:04:06Z
updated_at: 2023-10-26T10:02:25Z
---

# git: alias: deinit submodule

**Motivation:** I actively use it and want to reduce manual job.

**The algorithm**

```bash
$ git submodule deinit -f a/module
$ rm -rf .git/modules/a/module
$ git rm -f a/module
# it should remove module from .gitmodules too, but if not
$ git config -f .gitmodules --remove-section submodule.a/module
```

Checklist:
- `.git/config`
- `.git/modules/`
- `.gitmodules`
