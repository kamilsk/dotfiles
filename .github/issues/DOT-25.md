---
code: DOT-25
id: 25
database_id: 443775161
node_id: MDU6SXNzdWU0NDM3NzUxNjE=
status: closed
title: "invalid behavior of git start and git refresh"
labels: ["type: bug"]
url: https://github.com/kamilsk/dotfiles/issues/25
created_at: 2019-05-14T08:22:25Z
updated_at: 2022-08-14T18:59:51Z
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

First, `git start <id>` without a description died on an empty pathspec — the likely reading is that the empty "brief" was handed unguarded to `git checkout` or to a `grep` — while `git start <id> words…` worked. Second, `git refresh upstream` reported `master` up to date although the log disagreed; from the transcript alone it cannot be decided whether the fetch failed to update `upstream/master` or whether the local branch was simply ahead of it (a rebase then legitimately says "up to date"); the same symptom is [#27](DOT-27.md).

Expected: `git start 34` creates or switches to `issue-34` (with or without a suffix) and never touches pathspecs; `git refresh upstream` leaves the branch equal to or ahead of `upstream/master`, and its "up to date" message is true; neither prints `done` after a failure.
