---
id: 433
database_id: 1389379146
node_id: I_kwDOCTsueM5S0D5K
status: open
title: "git: alias: contribute: support multiple targets"
labels: [type: improvement, scope: code, impact: medium, effort: medium]
url: https://github.com/kamilsk/dotfiles/issues/433
created_at: 2022-09-28T13:37:10Z
updated_at: 2022-09-28T13:37:10Z
---

# git: alias: contribute: support multiple targets

**Motivation:** I have two streams, main and tact. They have different contribution targets, 5 and 10, respectively.

**Draft**

```bash
if $pwd ~= /tact-app/ then
    # support 10 as target
fi
# support 5 as target
```
