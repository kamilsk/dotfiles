---
code: DOT-82
id: MDU6SXNzdWU2ODYwMTc3NzI=
databaseId: 686017772
number: 83
url: https://github.com/kamilsk/dotfiles/issues/83
title: "problem cases after refactoring"
labels:
  - "type: bug"
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2020-08-26T05:28:06Z
updatedAt: 2026-09-17T11:15:10Z
lastEditedAt: 2026-09-17T11:15:10Z
closedAt: 2020-09-15T19:15:33Z
---

# problem cases after refactoring

Fix `git shake all` after a refactoring left quote characters inside the remote name. The original output (the Russian git lines mean "Fetching from origin", "Deleted branch XYZ (was a164ccab)", "Could not read from remote repository — make sure you have the correct access rights and the repository exists"):

```
Извлечение из origin
Ветка XYZ удалена (была a164ccab).
local branch XYZ was deleted
fatal: 'origin'' does not appear to be a git repository
fatal: Не удалось прочитать из внешнего репозитория.
remote branch origin'/'XYZ was deleted
fatal: 'origin'' does not appear to be a git repository
remote branch origin'/'ABC was deleted
```

The local sweep worked; the remote sweep split `origin/XYZ` into `origin'` and `'XYZ`, so `git push origin' :'XYZ` failed for every branch while the script still announced "remote branch … was deleted". The likely reading is a quoting mistake in the split, introduced by the refactoring the title refers to; the ticked box marks it as fixed.

Expected: `git shake all` deletes merged remote branches on every remote except `upstream`, and reports a deletion only when the push succeeded.

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/83#issuecomment-5711715562
Code vs intent: the quoting bug is fixed but the same lines now have the slash-split defect (branches with `/` in the name) and still print success regardless of the push result. See the note on #160.
-->
