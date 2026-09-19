---
code: DOT-45
id: MDU6SXNzdWU0NjkxNTYzMzY=
databaseId: 469156336
number: 46
url: https://github.com/kamilsk/dotfiles/issues/46
title: "remove [no tests to run]"
labels:
  - "type: bug"
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-07-17T12:10:30Z
updatedAt: 2026-09-17T11:10:56Z
lastEditedAt: 2026-09-17T11:10:56Z
closedAt: 2019-07-17T12:23:27Z
---

# remove [no tests to run]

Stop the `[no tests to run]` marker from breaking the `coverall` table ([[DOT-44]]). The original output:

```
$ coverall
ok  github.com/kamilsk/lift/internal/shell    0.0%   [no  tests  to  run]
ok  github.com/kamilsk/lift/internal/forward  26.8%
ok  github.com/kamilsk/lift/internal/config   36.8%
ok  github.com/kamilsk/lift                   0.0%   [no  tests  to  run]
?   github.com/kamilsk/lift/internal/cmd      0.0%
?   github.com/kamilsk/lift/internal          0.0%
total: 24.5%
```

The table is aligned with `column -t`, which treats every space as a separator, so the four words of the marker were spread across four columns. The marker carries no information beyond the `0.0%` already shown (a package with a test file but no matching tests), so it should simply be removed before alignment; the row itself stays.
