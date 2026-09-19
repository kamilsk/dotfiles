---
code: DOT-85
id: MDU6SXNzdWU3MzM3MzA2NzY=
databaseId: 733730676
number: 86
url: https://github.com/kamilsk/dotfiles/issues/86
title: "force date format"
labels:
  - "help wanted"
  - "type: bug"
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2020-10-31T14:19:04Z
updatedAt: 2026-09-17T11:15:17Z
lastEditedAt: 2026-09-17T11:15:17Z
closedAt: 2020-10-31T14:44:06Z
---

# force date format

Make `git at` independent of the user's locale. With a Russian `LC_TIME` the date computed for the commit was printed in localized long form and git refused it:

```sh
$ git at -41d ...
fatal: неправильный формат даты: воскресенье, 20 сентября 2020 г. 17:17:50 (MSK)
```

(the message is "invalid date format"). `date -v-41d` without an explicit `+FORMAT` prints in the locale's default representation, which git cannot parse; the helper has to request a fixed, machine-readable format.
