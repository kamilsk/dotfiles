---
id: 459
database_id: 1428997382
node_id: I_kwDOCTsueM5VLMUG
status: open
title: "config: git: disable advice.skippedCherryPicks"
labels: [type: improvement, scope: code, impact: low, effort: easy]
url: https://github.com/kamilsk/dotfiles/issues/459
created_at: 2022-10-30T19:53:02Z
updated_at: 2022-10-30T19:53:20Z
---

# config: git: disable advice.skippedCherryPicks

Related to #458 

```bash
$ git rebase main
warning: skipped previously applied commit d29d381
hint: use --reapply-cherry-picks to include skipped commits
hint: Disable this message with "git config advice.skippedCherryPicks false"
```
