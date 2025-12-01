---
id: 437
database_id: 1393817225
node_id: I_kwDOCTsueM5TE_aJ
status: closed
title: "update: docker: exit with 1 without any message"
labels: [type: bug, severity: minor, scope: code, impact: low, effort: easy]
url: https://github.com/kamilsk/dotfiles/issues/437
created_at: 2022-10-02T16:15:16Z
updated_at: 2022-10-02T18:51:30Z
---

# update: docker: exit with 1 without any message

**Steps to reproduce**

```bash
$ images all
# nothing
$ self-update docker || echo $?
# echo 1
```
