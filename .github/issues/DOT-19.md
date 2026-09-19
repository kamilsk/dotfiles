---
code: DOT-19
id: MDU6SXNzdWU0NDIxNzE4NTA=
databaseId: 442171850
number: 19
url: https://github.com/kamilsk/dotfiles/issues/19
title: "git aliases"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-05-09T10:44:26Z
updatedAt: 2026-09-17T11:00:11Z
lastEditedAt: 2026-09-17T11:00:11Z
closedAt: 2019-05-09T13:22:48Z
---

# git aliases

Add a way to see the configured git aliases in a readable form. `git config --get-regexp alias` prints one long line per alias, which is hard to scan once the list grows past a dozen entries and the bodies are multi-line shell snippets; the note suggests piping it through a small Python formatter:

```
$ git config --get-regexp alias | python
```

The intent is a `git aliases` command that lists the alias names and their bodies aligned and, ideally, grouped, so that the author can check what a given alias does without opening [git_config](../../bin/git_config).

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/19#issuecomment-5711687652
Code vs intent: `bin/git_aliases` (the Python formatter) is gone, `alias.aliases` is legacy-only, but `test/lookup.bats` still expects `bin/git_aliases: Python script text executable`. Either the test or the ticket's outcome is wrong; the code says the command was dropped.
-->
