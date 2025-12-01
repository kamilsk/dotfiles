---
id: 787
database_id: 3270096089
node_id: I_kwDOCTsueM7C6bTZ
status: closed
title: "bootstrap: broken installation script"
labels: [type: bug, severity: major, scope: code, impact: high, effort: easy]
url: https://github.com/kamilsk/dotfiles/issues/787
created_at: 2025-07-28T14:14:55Z
updated_at: 2025-07-28T14:17:59Z
---

# bootstrap: broken installation script

**Details**

```bash
$ curl -sSfL https://install.octolab.org/dotfiles | bash
bash: line 18: retunr: command not found
bash: line 116: return: can only `return' from a function or sourced script
```
