---
code: DOT-40
id: MDU6SXNzdWU0NjE5MzQwNTA=
databaseId: 461934050
number: 41
url: https://github.com/kamilsk/dotfiles/issues/41
title: "stash cd ... don't work properly"
labels:
  - "type: bug"
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-06-28T09:04:23Z
updatedAt: 2026-09-17T11:09:42Z
lastEditedAt: 2026-09-17T11:09:42Z
closedAt: 2019-07-11T08:55:52Z
---

# stash cd ... don't work properly

Make `cd` recordable by the `stash` command recorder ([[DOT-37]]) without breaking the interactive session. The original report is only the failing pair:

```bash
$ stash cd some-path
$ stash repeat
```

The recorder runs each command inside its own process (`eval "$*"` in a script), so a recorded `cd` changes the directory of that process and not of the caller's shell: the user stays where they were, and every command stashed afterwards runs from the wrong place, while on `repeat` the `cd` applies only inside the replay script. The expected behaviour is that after `stash cd some-path` the interactive shell is in `some-path` and later stashed commands are recorded and replayed relative to it, exactly as if the user had typed the commands without the prefix.
