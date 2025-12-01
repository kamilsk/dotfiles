---
id: 537
database_id: 1621429642
node_id: I_kwDOCTsueM5gpQ2K
status: open
title: "tools: github: support extension list"
labels: [type: feature, scope: code, impact: medium, effort: medium, scope: deps]
url: https://github.com/kamilsk/dotfiles/issues/537
created_at: 2023-03-13T12:53:34Z
updated_at: 2023-03-13T12:53:35Z
---

# tools: github: support extension list

**Motivation:** gh allows to extend it by extensions, e.g., https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows#force-deleting-cache-entries.

I want to restore all extensions and update them with `self-update` call.

**Current list**

```bash
$ gh extension install actions/gh-actions-cache
```
