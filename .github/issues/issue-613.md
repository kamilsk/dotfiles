---
id: 613
database_id: 1858799566
node_id: I_kwDOCTsueM5uywfO
status: closed
title: "command: flushdns"
labels: [type: feature, scope: code, impact: medium, effort: easy]
url: https://github.com/kamilsk/dotfiles/issues/613
created_at: 2023-08-21T07:45:16Z
updated_at: 2023-09-15T11:37:22Z
---

# command: flushdns

**Motivation:** avoid googling it or CleanMyMac launching whenever needed.

```bash
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
```
