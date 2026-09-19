---
code: DOT-25
id: MDU6SXNzdWU0NDM3NzUxNjE=
databaseId: 443775161
number: 25
url: https://github.com/kamilsk/dotfiles/issues/25
title: "invalid behavior of git start and git refresh"
labels:
  - "type: bug"
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-05-14T08:22:25Z
updatedAt: 2026-09-17T11:02:50Z
lastEditedAt: 2026-09-17T11:02:50Z
closedAt: 2019-05-15T13:38:05Z
---

# invalid behavior of git start and git refresh

Fix two misbehaviours seen while starting work on an issue. The original transcript:

```bash
$ git start 34
fatal: empty string is not a valid pathspec. please use . instead if you meant to match all paths
done

$ git start 34 port types
...
Current branch master is up to date.
Switch to the new branch «issue-34-port-types»
done

$ git refresh upstream
...
Current branch master is up to date.
# but git log shows that it is not true
```

First, `git start <id>` without a description died on an empty pathspec — the likely reading is that the empty "brief" was handed unguarded to `git checkout` or to a `grep` — while `git start <id> words…` worked. Second, `git refresh upstream` reported `master` up to date although the log disagreed; from the transcript alone it cannot be decided whether the fetch failed to update `upstream/master` or whether the local branch was simply ahead of it (a rebase then legitimately says "up to date"); the same symptom is [[DOT-27]].

Expected: `git start 34` creates or switches to `issue-34` (with or without a suffix) and never touches pathspecs; `git refresh upstream` leaves the branch equal to or ahead of `upstream/master`, and its "up to date" message is true; neither prints `done` after a failure.
