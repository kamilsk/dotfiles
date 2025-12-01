---
id: 626
database_id: 1910193032
node_id: I_kwDOCTsueM5x2zuI
status: open
title: "alias: dirs by column and dynamic selection"
labels: [type: feature, scope: code, impact: medium, effort: medium]
url: https://github.com/kamilsk/dotfiles/issues/626
created_at: 2023-09-24T10:58:39Z
updated_at: 2023-09-24T10:58:40Z
---

# alias: dirs by column and dynamic selection

**Motivation:** dirs shows all directories inline. I want to see them by column and optional make a selection to move between them.

Instead

```bash
$ dirs
~/Development/public/tact-app/inbox ~/Development/public/tact-app/app ~/Development/public/tact-app/airseat
```

I want

```bash
$ dirs
● ~/Development/public/tact-app/inbox
◦ ~/Development/public/tact-app/app
◦ ~/Development/public/tact-app/airseat
```
