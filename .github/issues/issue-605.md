---
id: 605
database_id: 1840156499
node_id: I_kwDOCTsueM5tro9T
status: open
title: "git: alias: single entry point x instead of current approach"
labels: [type: feature, scope: code, impact: high, effort: medium]
url: https://github.com/kamilsk/dotfiles/issues/605
created_at: 2023-08-07T20:24:54Z
updated_at: 2023-08-08T09:42:37Z
---

# git: alias: single entry point x instead of current approach

**Motivation:** simplify experience and avoid learning inappropriate patterns. Proxy is preferable to alias.

**Interface**

```bash
$ git x contrib
# instead of
# git contrib
```
