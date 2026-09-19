---
code: DOT-88
id: MDU6SXNzdWU3NzQ3NzY3MTA=
databaseId: 774776710
number: 89
url: https://github.com/kamilsk/dotfiles/issues/89
title: "extend lookup command"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2020-12-25T19:35:33Z
updatedAt: 2026-09-17T11:15:34Z
lastEditedAt: 2026-09-17T11:15:34Z
closedAt: 2020-12-27T15:37:41Z
---

# extend lookup command

Let `lookup git <alias>` follow a git alias down to the code that implements it. Many aliases of that time were `!git_commit at`-style shell-outs to scripts in `bin/`, so seeing only the alias body answered half of the question. The original sketch:

```bash
$ lookup git at
# git config alias.at
# !git_commit at
# lookup git_commit
```

That is: print the alias as `git config` returns it, and when the body starts with `!git_…` recurse into `lookup` for that script, which prints its source ([[DOT-39]]). Aliases whose body is plain git (`stash --keep-index`) or an inline shell snippet are shown as they are.

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/89#issuecomment-5711716025
Code vs intent: `lookup git <alias>` recursion is keyed on `!git_` and therefore stops at `!@ git-at` for every alias defined since 2021 (`at`, `cmm`, `amend`, `it`, `undo`, `contrib`, `rewrite`, stash family). Extending the match to `!@ ` and resolving the function in the sourced libraries would restore the feature.
-->
