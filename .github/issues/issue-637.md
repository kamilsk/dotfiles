---
id: 637
database_id: 1969915680
node_id: I_kwDOCTsueM51aocg
status: open
title: "git: command: pull must respect tagopt"
labels: [type: improvement, scope: code, impact: medium, effort: easy]
url: https://github.com/kamilsk/dotfiles/issues/637
created_at: 2023-10-31T08:36:04Z
updated_at: 2023-10-31T08:36:13Z
---

# git: command: pull must respect tagopt

**Motivation:** I use the GitHub template repository feature and register them as `upstream` to fetch changes and sync. But templates could contain tags. When I `pull` and `push`, these tags are also sent to `origin`.

See https://www.feliciano.tech/blog/tell-git-dont-fetch-tags/.

Example:
- https://github.com/obsidianmd/obsidian-sample-plugin and https://github.com/withsparkle/obsidian
